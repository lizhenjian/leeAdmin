<?php
namespace app\common\model;

use think\Model;

class Base extends Model
{
    protected $deleteTime = 'delete_time';
    protected $defaultSoftDelete = 0;

    protected function rows()
    {
        return app('request')->param('limit', config('paginate.list_rows'));
    }
}