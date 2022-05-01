--This SQL query generates a report in Stripe Sigma for all of your invoices. It includes an additional column that tells
--you whether or not a refund was processed for the invoice as well as an additional column that provides the amount of the refund 
--for the invoice. Somewhat surprisingly, these columns are not avaialable by default in the Invoices table in Stripe Sigma SQL.

SELECT
ch.id,
ch.created,
ch.description,
ch.amount,
ch.amount_refunded AS amount_refunded,
CASE
WHEN ch.amount_refunded = 0 THEN 'no refund'
WHEN ch.amount <> ch.amount_refunded THEN 'partial refund'
ELSE 'full refund'
END AS refunded_status,
--------
i.id AS invoice_id,
i.subscription_id,
i.number AS invoice_number,
cx.name,
cx.email,
s.plan_id,
pri.nickname
,pr.name AS price_name
--------
FROM
charges ch
--------
LEFT JOIN invoices i ON ch.id = i.charge_id
LEFT JOIN customers cx ON ch.customer_id = cx.id
LEFT JOIN subscriptions s ON i.subscription_id = s.id
LEFT JOIN prices pri ON s.price_id = pri.id
LEFT JOIN products pr ON pri.product_id = pr.id
--------
WHERE
ch.created < date('2022-01-01')
AND ch.status = 'succeeded'
ORDER BY
created DESC

