<?php
declare (strict_types = 1);

namespace app\api\controller\main;

use app\api\controller\Base;
use app\common\model\Content as ContentModel;
use think\App;

class Content extends Base
{

    private $content;

    public function __construct(ContentModel $content)
    {
        $this->content = $content;
        parent::__construct();

    }

    /**
     * @api {get} api/main.Content/getList 内容列表
     * @apiDescription 内容列表
     * @apiName getList
     * @apiGroup main-content
     * @apiParam {int} apartment_id
     * @apiParam {int} cate_id
     * @apiParam {int} content_group_id
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.Content/getList
     * @apiVersion 1.0.0
     */
    public function getList()
    {
        $data = input();
        $data = $this->content->getList($data);
        return $this->buildSuccess($data, 'ok');
    }

    /**
     * @api {get} api/main.Content/getInfo 内容详情
     * @apiDescription 内容详情
     * @apiName getInfo
     * @apiGroup main-content
     * @apiParam {int} id
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.Content/getInfo
     * @apiVersion 1.0.0
     */
    public function getInfo()
    {
        $param = input();
        $this->validate($param, [
            'id' => 'require',
        ]);
        $data = $this->content->getInfo($param['id']);
        return $this->buildSuccess($data, 'ok');
    }


}
