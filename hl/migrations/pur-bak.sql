-- 1 up
create table if not exists pur (
  id    serial primary key,
  -- 成本中心
  cost_center text default null,
  -- 部门
  department  text default null,
  -- 资产号
  assets text,
  -- 批次
  q_version text,
  -- 申请人
  applicant text,
  -- 采购类型
  pur_type text,
  -- 配置
  allocation text,
  -- 厂商
  brand text,
  -- 数量
  pur_number integer,
  -- 机房
  idc_room text,
  -- 采购原因
  pur_reason text,
  -- 采购状态 0: 审批， 1: 采购提交 2: 到货 3:结束
  state integer default 0,
  -- 采购状态中文
  state_cn text default null,
  -- 创建时间
  create_time  timestamp default '2018-01-01 00:00:00',
  -- 更新时间
  update_time  timestamp  DEFAULT NOW(),
  -- 评论
  remarks text default null
);

-- 1 down
--drop table if exists pur;
