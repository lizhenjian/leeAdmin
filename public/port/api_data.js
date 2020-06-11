define({ "api": [
  {
    "type": "get",
    "url": "api/main.WechatUser/login",
    "title": "微信公众号登录",
    "description": "<p>微信公众号登录</p>",
    "name": "jssdk",
    "group": "main-TcUser",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "code",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回 1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.WechatUser/login"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/WechatUser.php",
    "groupTitle": "main-TcUser"
  },
  {
    "type": "get",
    "url": "api/main.TcUser/loginTest",
    "title": "测试登录",
    "description": "<p>测试登录</p>",
    "name": "loginTest",
    "group": "main-TcUser",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "uid",
            "description": ""
          },
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "sign",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.WechatUser/loginTest"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/WechatUser.php",
    "groupTitle": "main-TcUser"
  },
  {
    "type": "get",
    "url": "api/main.TcUser/refreshJwt",
    "title": "刷新refresh_token",
    "description": "<p>刷新refresh_token</p>",
    "name": "refreshJwt",
    "group": "main-TcUser",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "refresh_token",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.TcUser/refreshJwt"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Jwt.php",
    "groupTitle": "main-TcUser"
  },
  {
    "type": "post",
    "url": "api/main.TcUser/update",
    "title": "用户信息更新",
    "description": "<p>用户信息更新</p>",
    "name": "update",
    "group": "main-TcUser",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "code",
            "description": ""
          },
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "nickName",
            "description": "<p>姓名</p>"
          },
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "gender",
            "description": "<p>性别</p>"
          },
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "avatarUrl",
            "description": "<p>头像</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.TcUser/update"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/TcUser.php",
    "groupTitle": "main-TcUser"
  },
  {
    "type": "get",
    "url": "api/main.Content/getInfo",
    "title": "内容详情",
    "description": "<p>内容详情</p>",
    "name": "getInfo",
    "group": "main-content",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "id",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.Content/getInfo"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Content.php",
    "groupTitle": "main-content"
  },
  {
    "type": "get",
    "url": "api/main.Content/getList",
    "title": "内容列表",
    "description": "<p>内容列表</p>",
    "name": "getList",
    "group": "main-content",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "apartment_id",
            "description": ""
          },
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "cate_id",
            "description": ""
          },
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "content_group_id",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.Content/getList"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Content.php",
    "groupTitle": "main-content"
  },
  {
    "type": "get",
    "url": "api/main.Slide/getList",
    "title": "幻灯片列表",
    "description": "<p>幻灯片列表</p>",
    "name": "getList",
    "group": "main-slide",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "slide_group_id",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.Slide/getList"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Slide.php",
    "groupTitle": "main-slide"
  },
  {
    "type": "get",
    "url": "api/main.util/jssdk",
    "title": "获取微信JSSDK",
    "description": "<p>获取微信JSSDK</p>",
    "name": "jssdk",
    "group": "main-util",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "array",
            "optional": false,
            "field": "js_api_list",
            "description": "<p>接口API列表</p>"
          },
          {
            "group": "Parameter",
            "type": "string",
            "optional": false,
            "field": "url",
            "description": "<p>链接</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回 1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.util/jssdk"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Util.php",
    "groupTitle": "main-util"
  },
  {
    "type": "post",
    "url": "api/main.util/upload",
    "title": "上传文件",
    "description": "<p>上传文件(本地存储)</p>",
    "name": "upload",
    "group": "main-util",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "file",
            "optional": false,
            "field": "file",
            "description": "<p>文件</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回 1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.util/upload"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Util.php",
    "groupTitle": "main-util"
  },
  {
    "type": "post",
    "url": "api/main.util/uploadCloud",
    "title": "上传文件",
    "description": "<p>上传文件(腾讯云对象存储)</p>",
    "name": "uploadCloud",
    "group": "main-util",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "file",
            "optional": false,
            "field": "file",
            "description": "<p>文件</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "optional": false,
            "field": "code",
            "description": "<p>返回 1</p>"
          }
        ]
      }
    },
    "sampleRequest": [
      {
        "url": "/api/main.util/uploadCloud"
      }
    ],
    "version": "1.0.0",
    "filename": "app/api/controller/main/Util.php",
    "groupTitle": "main-util"
  }
] });
