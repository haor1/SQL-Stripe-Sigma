--SQL query that I wrote for a User to generate a custom report in Stripe Sigma

select
ch.id,
ch.created,
ch.description,
ch.amount,
ch.amount_refunded as amount_refunded,
CASE
WHEN ch.amount_refunded = 0 THEN 'no refund'
WHEN ch.amount <> ch.amount_refunded THEN 'partial refund'
ELSE 'full refund'
END AS refunded_status,
--------
i.id as invoice_id,
i.subscription_id,
i.number as invoice_number,
cx.name,
cx.email,
s.plan_id,
pri.nickname
,pr.name as price_name
--------
from
charges ch
--------
left join invoices i on ch.id = i.charge_id
left join customers cx on ch.customer_id = cx.id
left join subscriptions s on i.subscription_id = s.id
left join prices pri on s.price_id = pri.id
left join products pr on pri.product_id = pr.id
--------
where
ch.created < date('2022-01-01')
and ch.status = 'succeeded'
order by
created desc

