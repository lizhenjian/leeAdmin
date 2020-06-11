<?php

namespace app\common\model;
use think\facade\Db;
class Admin extends Base {

    private function setParam(){
        $where = [];
        if(!empty($param['keywords'])) {
            $where[] = ['nickname|username|desc','like',$param['keywords'].'%'];
        }
        return $where;
    }
    public function getList($param){

        $where = $this->setParam($param);
        $list = $this
            ->field('id,username,nickname,status,last_login_time,desc,thumb,groups,last_login_ip')
            ->where($where)
            ->paginate([
                'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                'page'      => isset($param['page']) ? $param['page'] : 1,
                'query'     => $param
            ])
            ->each(function($item, $key){
                $item['groupName']       = implode('|',Db::name('admin_group')->where('id','in',explode(',',$item['groups']))->column('title'));
                $item['last_login_time'] = date('Y-m-d H:i:s',$item['last_login_time']);
                return $item;
            });
        return $list;
    }


}
