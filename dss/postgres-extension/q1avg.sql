select
    l_returnflag,
    l_linestatus,
    avg(l_quantity) as avg_qty
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


select
    l_returnflag,
    l_linestatus,
    ANON_AVG_WITH_BOUNDS(l_quantity, 1, 50, 0.1) as avg_qty
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