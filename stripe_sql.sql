--SQL query that I wrote for a User to generate a custom report in Stripe Sigma

select 
  i.id invoice_id,
  s.id subscription_id,
  i.total,
  il.plan_id,
  pri.nickname price_nickname,
  pr.name product_name, cx.name, cx.email,
  ch.amount_refunded as amount_refunded, 
  CASE WHEN ch.amount_refunded = 0 THEN 'no refund'
  WHEN i.total <> ch.amount_refunded THEN 'partial refund' 
  ELSE 'full refund' END AS refunded_status
from invoices i
join invoice_line_items il
  on il.invoice_id = i.id
join subscriptions s
  on s.plan_id = il.plan_id and s.id = i.subscription_id
join prices pri
  on pri.id = il.plan_id
join products pr
  on pr.id = pri.product_id
join customers cx
  on cx.id = i.customer_id
join charges ch
  on ch.invoice_id = i.id
where i.status = 'paid'

