/**
 * Created by zwm on 2017/5/17.
 */
var BizConstant = {
    SUCCESS: "1",
    ERROR: "-1",
    MAP_KEY: {
        BILLHEADER: "BillHeader"
        //票据编码
    },
    FEE_TYPE: {
        YR: "YR", 	// 直接应收
        YP: "YP", 	// 直接应付
        NR: "NR", 	// 间接应收
        NP: "NP" 	// 间接应付
    },
    FEE_STATUS: {
        FEE_STATUS_0: "0", 	// 暂存
        FEE_STATUS_1: "1", 	// 已提交
        FEE_STATUS_2: "2", 	// 部分对账
        FEE_STATUS_3: "3" 	// 完整对账
    },
    PAYMENT_TYPE: {
        RECEIVE: "1", 	// 应收
        PAY: "2",       // 应付
        PER_ORDER:"3"   //票结
    },
    FEE_OPERATION: {
        INSERT: "INSERT", 	//新增
        UPDATE: "UPDATE", 	//修改
        DELETE: "DELETE" 	//删除
    },
    /* 散客编码 */
    FIT_CODE1: "OG000565",
    FIT_CODE2: "OG000249",

    /* 对账状态 */
    BILL_STATUS_START: "1",    //对账开始
    BILL_STATUS_COMPLETE: "2", //对账完成

    /* 页面类型 */
    TYPE_EDIT: "edit",     //编辑
    TYPE_DETAIL: "detail", //明细

    /* 应收应付 */
    PAYMENT_TYPE_REV: "1", //应收
    PAYMENT_TYPE_PAY: "2", //应付

    /* 直接间接 */
    FEE_TYPE_DIRCT: "1",   //直接
    FEE_TYPE_INDIRCT: "2", //间接

    /* 费用状态  */
    FEE_STATUS_SUBMIT: "2",     //已提交
    FEE_STATUS_PART_RECON: "3", //已部分对账

    /*审批状态*/
    YES: "Y",
    NO: "N",

    /*字典表groupno*/
    GROUP_NO: {
        DEFAULT_VALUE: "",
        /*直接间接*/
        FEE_TYPE: "FEE_TYPE",
        /*应收应付*/
        PAYMENT_TYPE: "PAYMENT_TYPE",
        /*票据类型*/
        INVOICE_STATUS: "INVOICE_STATUS",
        /*票据状态*/
        INVOICE_TYPE: "INVOICE_TYPE",
        /*币种*/
        CURRENCY_CODE: "CURRENCY_CODE",
        /*系统确认标志*/
        SYS_CONFIRM_FLAG: "SYS_CONFIRM_FLAG",
        /*预算分类*/
        MAIN_TYPE: "MAIN_TYPE"
    },
    INVOICE_TYPE: {
        RECEIPT: "1",	//收款单
        PRE_RECEIPT: "2",	//预收款单
        PAYMENT: "3",	//付款单
        PRE_PAYMENT: "4",	//预付款单
        FINANCE_BALANCE: "5"	//财务平衡单
    },
    INVOICE_STATUS: {
        AWAIT_APPROVAL: "1",	//等待审批
        AWAIT_PAYMENT: "2",	//等待收付款
        HANDLING: "3",		//处理中
        COMPLETE_FI_DOME: "4"	//核销完成
    },
   PRE_INVOICE_STATUS: {
		AWAIT_APPROVAL: "1",	//等待审批
		AWAIT_PAYMENT: "2",	//等待收付款
		HANDLING: "3",		//处理中
		COMPLETE_ACCOUNT: "4"	//入账完成
	},
    FI_DONE_TYPE: {
        REC_PRE_REC_INVOICE: "1",		//实收-预付款单
        PAY_PRE_PAY_INVOICE: "2",		//实付-预付款单
        REC_REC_INVOICE: "3",		//实收-收款单
        PAY_PAY_INVOICE: "4",		//实付-付款单
        REC_PAY_INVOICE: "5",		//收款单-付款单
        PRE_REC_REC_INVOICE: "6",		//预收款单-收款单
        PRE_PAY_PAY_INVOICE: "7",		//预付款单-付款单
        FORCE_FI_DONE_INVOICE: "8" 	//强核销-账票
    },
    FORCE_FI_DONE_TYPE: {
        FORCE_FI_DONE_TYPE_1: "1",		//收款单
        FORCE_FI_DONE_TYPE_2: "2",		//预收款单
        FORCE_FI_DONE_TYPE_3: "3",		//付款单
        FORCE_FI_DONE_TYPE_4: "4",		//预付款单
        FORCE_FI_DONE_TYPE_5: "5"		//日记账单
    },
    FI_DONE_STATUS: {
        AWAIT_APPROVAL: "1", 	//等待审批
        AWAIT_FI_DONE: "2",		//等待核销
        COMPLETE_FI_DOME: "3",		//核销完成
        CANCEL_FI_DONE: "4",		//核销取消
        COMPLETE_RECON: 5,      // 入款完成
        CANCEL_RECON: 6      // 入款取消
    },
    FI_DONE_NO: "fi_done",		//核销numberingCode
    CASH_JOURNAL_PAYMENT_TYPE: {
        RECEIVE: "1", 		//收入
        PAY: "2"		//支出
    },
    APPROVAL_FLAG: {
        YES: "已审核",
        NO: "未审核"
    },
    COMPY_APP_NEED_FLAG: {
        YES: "需要承认",
        NO: "不需要承认"
    },
    CHECK_STATUS:{
        CHECK_STATUS_1 : "1", 		//完全匹配
        CHECK_STATUS_2 : "2",		//不匹配
        CHECK_STATUS_3 : "3",		//部分匹配
        CHECK_STATUS_4 : "4",		//未校验
        CHECK_STATUS_5 : "5"		//代收匹配
    },
    RECON_STATUS: {
        RECON_STATUS_1 : "1", 		//未核对
        RECON_STATUS_2 : "2",		//核对完成
        RECON_STATUS_3 : "3",		//生成账单
        RECON_STATUS_4 : "4"		//已拆分
    },
    BELONG_COMPY: {
        ZG_BELONG_COMPY_CODE:"OG000000",
        ZG_BELONG_COMPY_NAME:"兆冠接单",
        YD_BELONG_COMPY_CODE:"OG000436",
        YD_BELONG_COMPY_NAME:"运道接单",
    }
    ,/*照片类型*/
    PICTURE_TYPE: "PICTURE_TYPE"
}