WITH _t1 AS (
select
	p_brand,
	p_type,
	p_size,
	ps_suppkey
from
	partsupp,
	part
where p_partkey = ps_partkey
	and p_brand <> 'Brand#45'
	and p_type not like 'MEDIUM POLISHED%'
	and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
   ),
 _s1 AS (select * from supplier where s_comment like '%Customer%Complaints%')
select 	
    p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from 
    _t1 left join _s1 on _t1.ps_suppkey = _s1.s_suppkey
where
    _s1.s_suppkey IS NULL
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size;




explain analyze WITH _t1 AS (
select
	p_brand,
	p_type,
	p_size,
	ps_suppkey
from
	partsupp,
	part
where p_partkey = ps_partkey
	and p_brand <> 'Brand#45'
	and p_type not like 'MEDIUM POLISHED%'
	and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
   ),
 _s1 AS (select * from supplier where s_comment like '%Customer%Complaints%')
select 	
    p_brand,
	p_type,
	p_size,
	ANON_COUNT(distinct ps_suppkey, 0.1) as supplier_cnt
from 
    _t1 left join _s1 on _t1.ps_suppkey = _s1.s_suppkey
where
    _s1.s_suppkey IS NULL
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size
limit 5;