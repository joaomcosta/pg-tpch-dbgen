select
    l_returnflag,
    l_linestatus,
    sum(l_quantity) as sum_qty
from
    lineitem
where
    l_shipdate <= date '1998-09-01'
group by
    l_returnflag,
    l_linestatus
order by
    l_returnflag,
    l_linestatus;


explain analyze select
    l_returnflag,
    l_linestatus,
    ANON_SUM_WITH_BOUNDS(l_quantity, 1, 50, 0.1) as sum_qty
from
    lineitem
where
    l_shipdate <= date '1998-09-01'
group by
    l_returnflag,
    l_linestatus
order by
    l_returnflag,
    l_linestatus;