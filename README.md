# SQL-Stripe-Sigma

This SQL query generates a report in Stripe Sigma for all of your invoices. It includes an additional column that tells
you whether or not a refund was processed for the invoice as well as an additional column that provides the amount of the refund 
for the invoice. Somewhat surprisingly, these columns are not available by default in the Invoices table in Stripe Sigma SQL.

