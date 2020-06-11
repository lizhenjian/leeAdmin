<?php
namespace app\common\model;

class Slide extends Base
{

    public function getIconAttr($value)
    {
        return filepath($value);
    }
    public function setIconAttr($value)
    {
        return setFilepath($value);
    }
    public function getList($param)
    {
        $where = [];
        if (!empty($param['slide_group_id'])) {
            $where['slide_group_id'] = $param['slide_group_id'];
        }
        $list = $this
            ->where($where)
            ->order('sort desc')
            ->paginate($this->rows());
        return $list;
    }

}
