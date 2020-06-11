<?php
declare (strict_types = 1);

namespace app\api\controller\main;

use app\api\controller\Base;
use app\common\model\Slide as SlideModel;
use think\App;

class Slide extends Base
{

    private $slide;

    public function __construct(SlideModel $slide)
    {
        $this->slide = $slide;
        parent::__construct();

    }

    /**
     * @api {get} api/main.Slide/getList 幻灯片列表
     * @apiDescription 幻灯片列表
     * @apiName getList
     * @apiGroup main-slide
     * @apiParam {int} slide_group_id
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.Slide/getList
     * @apiVersion 1.0.0
     */
    public function getList()
    {
        $data = input();
        $data = $this->slide->getList($data);
        return $this->buildSuccess($data, 'ok');
    }



}
