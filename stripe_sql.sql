--SQL query that I wrote for a User to generate a custom report in Stripe Sigma

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
left JOIN invoices i ON ch.id = i.charge_id
left JOIN customers cx ON ch.customer_id = cx.id
left JOIN subscriptions s ON i.subscription_id = s.id
left JOIN prices pri ON s.price_id = pri.id
left JOIN products pr ON pri.product_id = pr.id
--------
WHERE
ch.created < date('2022-01-01')
AND ch.status = 'succeeded'
ORDER BY
created DESC

