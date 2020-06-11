<?php
namespace app\common\model;
use think\model\concern\SoftDelete;

class User extends Base
{
    use SoftDelete;
    protected $autoWriteTimestamp = true;
    protected $deleteTime = 'delete_time';

    public static $sexData = [
        0 => '未知',
        1 => '男',
        2 => '女',
    ];

    public function getSexAttr($value)
    {
        return self::$sexData[$value];
    }

    public function getList($param)
    {
        $where = [];
        if (!empty($param['keywords'])) {
            $where[] = ['id|nickname|mobile','like', "%{$param['keywords']}%"];
        }
        $rows = empty($param['limit']) ? config('app.paginate.list_rows') : $param['limit'];
        $list = $this->where($where)
            ->order('id desc')
            ->paginate([
                'list_rows' => $rows,
                'page'      => isset($param['page']) ? $param['page'] : 1,
                'query'     => $param
            ]);
        return $list;
    }

    public function getUserInfo($id)
    {
        $info = $this->find($id);
        return $info;
    }

    public function updateUser($param)
    {
        $result = $this->update($param);
        return $result;
    }

    public function login($data)
    {

        $info = $this->where(['openid'=>$data['openid']])->find();
        if (empty($info)) {
            $this->create($data);
            $userId = $this->getLastInsId();
        } else {
            $userId = $info->id;
        }
        return $userId;
    }
}
