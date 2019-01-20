SELECT DISTINCT ON (concat(min(sold_at)::date::text, ' - ', max(sold_at)::date::text)) concat(min(sold_at)::date::text, ' - ', max(sold_at)::date::text) AS Week,
                   coffeeshops.name AS Cofeeshop,
                   employees.name AS Employee,
                   sum(price) AS Revenue
FROM transactions
INNER JOIN employees ON transactions.employee_id = employees.id
INNER JOIN coffeeshops ON transactions.coffeeshop_id = coffeeshops.id
GROUP BY date_part('week', sold_at),
         Employee,
         coffeeshops.name
ORDER BY concat(min(sold_at)::date::text, ' - ', max(sold_at)::date::text),
         Revenue DESC;

###########################


Your answer seems wrong:

| 2018-12-03 - 2018-12-09 | Coffeeshop B   | John Smith      |                            6465.35 |


select sum(price) from transactions inner join employees on transactions.employee_id = employees.id inner join coffeeshops on transactions.coffeeshop_id = coffeeshops.id where sold_at between '2018-12-03 00:00:00'::timestamp and '2018-12-09 23:59:59' and employees.name = 'John Smith' and coffeeshops.name = 'Coffeeshop B';
   sum
---------
 7543.00
(1 row)


7543.00 != 6465.35
