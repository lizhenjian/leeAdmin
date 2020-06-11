<?php
namespace app\common\model;
use think\model\concern\SoftDelete;

class Content extends Base
{
    use SoftDelete;

    public function getImgAttr($value)
    {
        return filepath($value);
    }
    public function setImgAttr($value)
    {
        return setFilepath($value);
    }
    public function getList($param)
    {
        $where = [];
        if (!empty($param['content_group_id'])) {
            $where['content_group_id'] = $param['content_group_id'];
        }
        if (!empty($param['cate_id'])) {
            $where['cate_id'] = $param['cate_id'];
        }
        $list = $this
            ->where($where)
            ->order('id desc')
            ->paginate($this->rows());
        return $list;
    }

    public function getInfo($id)
    {
        $info = $this
            ->find($id);
        return $info;
    }

}
