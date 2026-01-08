select yi.Item_id, dadi.NODE, 
COALESCE(dadi.AVAILABLE_QTY, 0) AS AVAILABLE_QTY ,
CASE WHEN dadi.AVAILABLE_QTY > 0 THEN 'AVL' ELSE 'UAVL' END AS availability_status,
NOW() AS AVAILABLE_time
from yfs_item yi
LEFT JOIN TITAN_DADI_INV_AVL_STAGING dadi 
ON TRIM(yi.Item_id) = TRIM(dadi.Item_id)
where 
yi.organization_code='TITAN_GCC' and
dadi.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG','XSR') order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;




Table 1 items
item 1
item 2
item 3
table 2 inv
item 1
tiem 3


item 1 - aval
item 2 - navl
item 3 - avl