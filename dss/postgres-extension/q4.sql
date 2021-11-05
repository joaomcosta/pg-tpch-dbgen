select
    o_orderpriority,
    count(o_orderkey) as order_count
from
    orders
where
    o_orderdate >= date '1993-07-01'
    and o_orderdate < date '1993-10-01'
    and exists (
        select
            *
        from
            lineitem
        where
            l_orderkey = o_orderkey
        and l_commitdate < l_receiptdate
    )
group by
    o_orderpriority
order by
    o_orderpriority;

select
    o_orderpriority,
    ANON_COUNT(o_orderkey, 0.1) as order_count
from
    orders
where
    o_orderdate >= date '1993-07-01'
    and o_orderdate < date '1993-10-01'
    and exists (
        select
            *
        from
            lineitem
        where
            l_orderkey = o_orderkey
        and l_commitdate < l_receiptdate
    )
group by
    o_orderpriority
order by
    o_orderpriority;


-- SAMPLE SIZE= 52523 