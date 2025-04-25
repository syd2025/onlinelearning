import '../locale_keys.dart';

/// 多语言 中文
Map<String, String> localeZh = {
  // 通用
  LocaleKeys.commonSearchInput: '输入关键字',
  LocaleKeys.commonBottomSave: '保存',
  LocaleKeys.commonBottomRemove: '删除',
  LocaleKeys.commonBottomCancel: '取消',
  LocaleKeys.commonBottomConfirm: '确认',
  LocaleKeys.commonBottomApply: '应用',
  LocaleKeys.commonBottomBack: '返回',
  LocaleKeys.commonSelectTips: '请选择',
  LocaleKeys.commonMessageSuccess: '@method 成功',
  LocaleKeys.commonMessageIncorrect: '@method 不正确',

  // 样式
  LocaleKeys.stylesTitle: '样式 && 功能 && 调试',

  // 验证提示
  LocaleKeys.validatorRequired: '字段不能为空',
  LocaleKeys.validatorEmail: '请输入 email 格式',
  LocaleKeys.validatorMin: '长度不能小于 @size',
  LocaleKeys.validatorMax: '长度不能大于 @size',
  LocaleKeys.validatorPassword: '密码长度必须 大于 @min 小于 @max',

  // welcome 欢迎
  LocaleKeys.welcomeOneTitle: '选择您喜欢的产品',
  LocaleKeys.welcomeOneDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeTwoTitle: '完成您的购物',
  LocaleKeys.welcomeTwoDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeThreeTitle: '足不出户的购物体验',
  LocaleKeys.welcomeThreeDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeSkip: '跳过',
  LocaleKeys.welcomeNext: '下一页',
  LocaleKeys.welcomeStart: '立刻开始',

  // APP 导航
  LocaleKeys.tabBarHome: '首页',
  LocaleKeys.tabBarCourse: '课程',
  LocaleKeys.tabBarStudy: '学习',
  LocaleKeys.tabBarProfile: '我的',

  // 我的
  LocaleKeys.clickLogin: '点击登录',
  LocaleKeys.welcomeLogin: '欢迎登录学习网，开启您的学习之旅',
  LocaleKeys.shoppingCart: '购物车',
  LocaleKeys.myOrder: '我的订单',
  LocaleKeys.favoriteCourse: '收藏课程',
  LocaleKeys.aboutLearning: '关于学习网',
  LocaleKeys.welcomePage: '欢迎页',
  LocaleKeys.ratingMe: '给我评分',
  LocaleKeys.editProfile: '编辑资料',
  LocaleKeys.logout: '退出登录',
  LocaleKeys.profileFooter: '编织梦想，实现未来',
  LocaleKeys.learnedDays: '已学习',
  LocaleKeys.day: '天',
  LocaleKeys.learningMinutes: '总时长',
  LocaleKeys.minute: '分钟',
  LocaleKeys.hour: '小时',
  LocaleKeys.exitSuccess: '退出成功',
  LocaleKeys.exitFailed: '退出失败',
  LocaleKeys.loginSuccess: '登录成功',
  LocaleKeys.loginFailed: '登录失败',
  LocaleKeys.networkUnavailable: '网络不可用',
  LocaleKeys.failToConnectToServer: '连接服务器失败',
  LocaleKeys.profileTitle: '用户资料',

  // 用户信息
  LocaleKeys.avatar: '头像',
  LocaleKeys.nickname: '昵称',
  LocaleKeys.nicknameHint: '请输入昵称',
  LocaleKeys.nicknameCannotBeEmpty: '昵称不能为空',
  LocaleKeys.gender: '性别',
  LocaleKeys.male: '男',
  LocaleKeys.female: '女',
  LocaleKeys.profession: '职业',
  LocaleKeys.region: '地区',
  LocaleKeys.introduction: '简介',
  LocaleKeys.signatureHint: '请输入签名',
  LocaleKeys.accountSecurity: '账户安全',
  LocaleKeys.accountSecurityTip: '手机号、密码修改、账号绑定',
  LocaleKeys.invalidImage: '无效的图片',
  LocaleKeys.photoAccessDenied: '未授予相册权限',
  LocaleKeys.uploadingImage: '正在上传图片...',
  LocaleKeys.uploadImageSuccess: '图片已更新成功',
  LocaleKeys.uploadImageFailed: '图片已更新失败',
  LocaleKeys.updateNickName: '更新昵称',
  LocaleKeys.updateProfession: '更新职业',
  LocaleKeys.updateIntroduction: '更新简介',
  LocaleKeys.updateRegion: '更新地区',
  LocaleKeys.selectRegion: '选择地区',
  LocaleKeys.regionCannotBeEmpty: '地区不能为空',

  // security
  LocaleKeys.notBind: '未绑定',
  LocaleKeys.bind: '绑定账号',
  LocaleKeys.phone: '手机',
  LocaleKeys.qq: 'QQ',
  LocaleKeys.wechart: '微信',
  LocaleKeys.weibo: '微博',
  LocaleKeys.thirdAuthAccount: '第三方账号',
  LocaleKeys.phoneHintText: '请输入手机号',
  LocaleKeys.email: '邮箱',
  LocaleKeys.emailHintText: '请输入手机号或邮箱',
  LocaleKeys.accountHintText: '请输入账号',
  LocaleKeys.thirdAccount: '第三方账号',
  LocaleKeys.passwordSetting: '密码设置',
  LocaleKeys.identityVerification: '实名认证',
  LocaleKeys.accountDeletion: '账号注销',
  LocaleKeys.changeEmail: '更换邮箱',
  LocaleKeys.changePhone: '更换手机',
  LocaleKeys.bindEmail: '绑定邮箱',
  LocaleKeys.bindPhone: '绑定手机',
  LocaleKeys.emailAlreadyUsed: '邮箱已被使用',
  LocaleKeys.phoneNumberAlreadyUsed: '手机已被使用',
  LocaleKeys.emailVerifyCodeSended: '邮箱验证码已发送',
  LocaleKeys.phoneVerifyCodeSended: '手机验证码已发送',
  LocaleKeys.findPassword: '找回密码',
  LocaleKeys.newPassword: '新密码',
  LocaleKeys.confirmPassword: '确认密码',
  LocaleKeys.oldPassword: '旧密码',
  LocaleKeys.resetPassword: '重置密码',
  LocaleKeys.newAndOldPasswordSame: '新密码与旧密码不能相同',
  LocaleKeys.will: '将',
  LocaleKeys.cancelTailTip: '的绑定账号注销',
  LocaleKeys.cancelHintHeader: '注销账号后以下信息将被清空并无法找回',
  LocaleKeys.cancelHint1: '· 学习网平台无法使用此账号',
  LocaleKeys.cancelHint2: '· 身份、账户信息',
  LocaleKeys.cancelHint3: '· 交易记录、学习记录等',
  LocaleKeys.cancelHint4: '· 余额、优惠券、积分等',
  LocaleKeys.cancelHintFooter: '请确保所有交易已完结且无纠纷，账户注销后的历史交易可能产生的资金退回权益等将视作自动放弃',
  LocaleKeys.cancelButtonTip: '点击下方“同意注销“按钮，即表示您已阅读并同意\n',
  LocaleKeys.cancelPrivacyPolicy: '《账号注销协议》',
  LocaleKeys.userCancelPolicy: '用户注销协议',
  LocaleKeys.agreeCancel: '同意注销',
  LocaleKeys.notVerified: '尚未认证',
  LocaleKeys.identityVerificationTipTitle: '认证须知',
  LocaleKeys.identityVerificationTip: """
    1.实名认证可以提升您在学习平台上个人信息和虚拟财产的安全等级，并让您更好地体验平台上的各种虚拟服务。
    2.实名认证审核通过后，您将无法修改或删除相关信息，请务必仔细填写。
    3.我们将严格保密您提供的所有信息，绝不对外披露。
    4.如恶意填写虚假姓名或身份证号码，一经发现，您的学习平台账户将被冻结。
    5.如多次未通过审核，请联系 learningcenter@126.com。
  """,
  LocaleKeys.verify: '认证',

  // category
  LocaleKeys.allCourses: '全部课程',
  LocaleKeys.all: '全部', // 全部 Cours
  LocaleKeys.searchCourse: '搜索课程', // 搜索课程
  LocaleKeys.beginner: '初级', // 初级
  LocaleKeys.intermediate: '中级', // 中级
  LocaleKeys.advanced: '高级', // 高级
  LocaleKeys.loadingMore: '加载更多', // 加载更多
  LocaleKeys.studying: '学习中', // 学习中
  LocaleKeys.myCourses: '我的课程', // 我的课程
  LocaleKeys.studyingCountTip: '人在学', // 共学习
  LocaleKeys.searchHint: '搜一搜',
  LocaleKeys.hotSearch: '热门搜索', // 热门搜索
  LocaleKeys.searchHistory: '搜索历史', // 搜索历史
  LocaleKeys.courseAlreadyPurchased: '课程已购买', // 课程已购买
  LocaleKeys.refoundTip: '7天可退款', // 退款说明
  LocaleKeys.courseDetail: '课程详情', // 课程详情
  LocaleKeys.courseLevel: '课程难度', // 课程等级
  LocaleKeys.videoDuration: '视频时长', // 视频时长
  LocaleKeys.studentCount: '学生人数', // 学生人数
  LocaleKeys.courseRating: '课程评分', // 课程评分
  LocaleKeys.noRatings: '暂无评分', // 暂无评分
  LocaleKeys.freeWatch: '免费试看', // 免费试看
  LocaleKeys.putToCart: '加入购物车', // 加入购物车
  LocaleKeys.goToLearn: '立即学习', // 立即学习
  LocaleKeys.buyNow: '立即购买', // 立即购买
  LocaleKeys.courseBrief: '简介', // 课程简介
  LocaleKeys.courseCatalog: '目录', // 课程目录
  LocaleKeys.courseComment: '评论', // 课程评论
  LocaleKeys.courseDescription: '课程介绍',
  LocaleKeys.courseSkills: '你将学到',
  LocaleKeys.authorIntroduction: '作者简介', // 作者简介 Author Introduction Detai
  LocaleKeys.reply: '回复', // 回复 Reply Detai
  LocaleKeys.editReply: '编辑回复', // 编辑回复 Edit Reply Detai
  LocaleKeys.editReview: '编辑评论', // 编辑评论 Edit Review Detai
  LocaleKeys.teacherReply: '老师回复: ', // 老师回复 Teacher Reply Detai
  LocaleKeys.myReply: '我的回复', // 我的回复 My Reply Detai
  LocaleKeys.myReview: '我的评论', // 我的评论 My Review Detai
  LocaleKeys.fullScoreTip: '满分 5 分', // 满分 Full Score Detai
  LocaleKeys.reviewCountTip: '条评论', // 条评论 Review Count Detai
  LocaleKeys.replyHint: '请输入回复内容', // 回复 Reply Detai
  LocaleKeys.contentCannotBeEmpty:
      '内容不能为空', // 内容不能为空 Content Cannot Be Empty Detai
  LocaleKeys.replySuccess: '回复成功', // 回复成功 Reply Success Detai
  LocaleKeys.reviewSuccess: '评论成功', // 确认 Confirm Detai
  LocaleKeys.courseAlreadyInShoppingCart:
      '课程已在购物车', // 课程已在购物车 Course Already In Shopping Cart Detai
  LocaleKeys.coursePurchased: '课程购买成功', // 课程已购买 Course Purchased Detai
  LocaleKeys.myRating: '我的评论', // 我的评分 My Rating Detai
  LocaleKeys.favorite: '已收藏', // 收藏 Favorite Detai
  LocaleKeys.unfavorite: '取消收藏', // 取消收藏 Unfavorite Detai
  LocaleKeys.courseAdded: '课程已加入购物车',
  LocaleKeys.confrimPurchase: '确认购买', // 确认购买 Confrim Purchase Detai
  LocaleKeys.coursePrice: '课程价格：￥', // 课程价格 Course Price Detai

  // study
  LocaleKeys.noCourseGoFind: '课表空空，去找课程吧',
  LocaleKeys.learning: '学习', // 学习 Learning Detai
  LocaleKeys.videoCount: '视频数: ', // 共 @count 集 Video Count Detai
  LocaleKeys.duration: '时长: ', // 共 @count 分钟 Duration Detai
  LocaleKeys.writeReivew: '撰写评论', // 写评论 Write Review Detai
  LocaleKeys.progress: '进度: ', // 进度 Progress Detai

  // 默认设置
  LocaleKeys.defaultStrings: '正在加载数据中...',
  LocaleKeys.gettingInfo: '正在获取信息',
  LocaleKeys.getInfoFailed: '获取信息失败',
  LocaleKeys.getInfoSuccess: '获取信息成功',
  LocaleKeys.updateSuccess: '更新成功',
  LocaleKeys.updateFailed: '更新失败',
  LocaleKeys.ok: '确定',
  LocaleKeys.unknownError: '未知错误',
  LocaleKeys.reload: '重新加载',
  LocaleKeys.disagreeProtocol: '不同意协议',
  LocaleKeys.agreeProtocol: '同意协议并继续',

  // 登录 - back login
  LocaleKeys.login: '登录',
  LocaleKeys.submit: '提交',
  LocaleKeys.inputVerifyCode: '请输入验证码',
  LocaleKeys.getCapcha: '获取验证码',
  LocaleKeys.loginFooterText1: '登录即表示您同意',
  LocaleKeys.loginFooterText2: '《学习网注册协议》',
  LocaleKeys.loginFooterText3: '和',
  LocaleKeys.loginFooterText4: '《隐私政策》',
  LocaleKeys.userProtocol: '用户协议',
  LocaleKeys.passwordLogin: '密码登录',
  LocaleKeys.phoneVerifyCodeLogin: '手机验证码登录',
  LocaleKeys.emailVerifyCodeLogin: '邮箱验证码登录',
  LocaleKeys.phoneVerifyTip: '未注册手机号验证后自动注册并登录',
  LocaleKeys.emailVerifyTip: '未注册邮箱验证后自动注册并登录',
  LocaleKeys.passwordHintText: '请输入密码',
  LocaleKeys.forgetPassword: '忘记密码',
  LocaleKeys.alertTipStartText: '为保障您的合法权益，请您阅读并同意',
  LocaleKeys.verifyCodeLogin: '验证码登录',
  LocaleKeys.phoneNumberVerifyCodeSended: '手机验证码已发送，请注意查收',

  // 更改邮箱
  LocaleKeys.changeEmailTitle: '更改邮箱',
  LocaleKeys.changeEmailDesc: '输入您的新邮箱地址',
  LocaleKeys.changeEmailFormTip: '邮箱',
  LocaleKeys.changeEmailButton: '提交',

  // 更改手机
  LocaleKeys.changePhoneTitle: '更改手机',
  LocaleKeys.changePhoneDesc: '输入您的新手机号码',
  LocaleKeys.changePhoneFormTip: '手机',
  LocaleKeys.changePhoneButton: '提交',
};
