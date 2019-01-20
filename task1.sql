ANSWER:

SELECT concat(min(sold_at)::date::text, ' - ', max(sold_at)::date::text) AS Week,
       sum(price) AS Revenue
FROM transactions
GROUP BY date_part('week', sold_at);

###########################################




# YOU HAVE AN ERROR IN SQL task1, in this line:
| 2018-12-03 - 2018-12-09 |                           37530.90 |
# It is not correct.

this query:
select sum(price) from transactions where sold_at between '2018-12-03'::date and '2018-12-09'::date;
   sum
----------
 37530.90
(1 row)

is equal to this:
select sum(price) from transactions where sold_at between '2018-12-03 00:00:00'::timestamp and '2018-12-08 23:59:59'::timestamp;
   sum
----------
 37530.90
(1 row)


but not to this:
select sum(price) from transactions where sold_at between '2018-12-03 00:00:00'::timestamp and '2018-12-09 23:59:59'::timestamp;
   sum
----------
 43799.90
(1 row)


There is difference in one day.

If you try to sum results from my query you will see:

43799.90 + 44016.75 + 44193.65 + 43582.00 == (select sum(price) from transactions);
