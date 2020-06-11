<?php

namespace app\common\model;

use think\facade\Db;

class AdminUserAction extends Base {

    private function setParam($param){
        $where = [];
        if(!empty($param['keywords'])) {
            $where[] = ['nickname|m.title','like',$param['keywords'].'%'];
        }
        return $where;
    }
    public function getList($param){
        $where = $this->setParam($param);
        $list = $this
            ->alias('a')
            ->join('admin_rule m' ,'a.url = m.src')
            ->field('a.*,m.title')
            ->where($where)
            ->order('id desc')
            ->paginate([
                'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                'page'      => isset($param['page']) ? $param['page'] : 1,
                'query'     => $param
            ])->each(function($item, $key){
                $item['add_time'] = date('Y-m-d H:i:s',$item['add_time']);
                return $item;
            });
        return $list;
    }
}
