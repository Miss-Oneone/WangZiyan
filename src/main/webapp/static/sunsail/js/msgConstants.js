/**
 * Created by zwm on 2017/5/17.
 */
var MsgConstants = {
    msg: {
        M00001:'请选择{0}！',
        M00002:'勾选数据中含有状态{0}，请先剔除掉再操作。',
        M00003:'一张票据只能选择同一个往来单位的账单来生成！',
        M00004:'勾选的账单中存在不同的散客，无法生成到同一张票据中！',
        M00005:'直接(业务费用)账单和间接账单(非业务费用)无法生成到同一张票据中！',
        M00006:'查询不到数据，请重新设置查询条件！',
        M00007:'账单状态为:{0}，不允许修改！',
        C00008:'确定要导出{0}?',
        C00009:'确定要进行{0}？',
        C00010:'确定要删除对账单数据?',
        M00011:'请输入{0}！',
        M00012:'{0}不能等于{1}！',
        M00013:'账单明细数据已全部删除！',
        M00014:'没有票据可以关联！',
        M00015:'请填写本次关联金额！',
        C00016:'您确定要进行核销核销关联？',
        M00017:'{0}不能小于{1}！',
        M00018:'{0}不能大于{1}！',
        M00019:'只有状态为{0}的数据才能进行{1}！',
        M00020:'预收付款入款不能进行取消核销处理！',
        M00021:'该笔票据的状态已经不能作废。',
        C00022:'当前数据还未提交,确认关闭？',
        M00023:'当前数据已提交，非创建者本人不能编辑！',
        M00024:'当前数据{0},已不能修改了！',
        M00025:'勾选的数据含有别人创建的数据，请仔细确认，或先剔除掉再操作！',
        M00026:'只有【等待审批】的{0}才需要审核。',
        C00027:'页面已经被修改，是否{0}？',
        M00028:'只有票据状态为等待审批或等待收付款的票据才允许作废。',
        C00029:'是否以当前选中的{0}（{1}）为关联信息，创建一笔日记账？',
        M00030:'账单中存在未审核的数据不能开具票据!',
        M00031:'只有票据状态为【等待收付款】【处理中】的{0}才能做日记账登记。',
        M00032:'操作成功{0}',
        M00033:'未关联金额已经为0的，不能够进入日记账登记。',
        M00034:'只有{0}才能进行{1}!',
        M00035:'存在{0},不能{1}!',
        M00036:'只有开票状态为作废才允许删除。',
        M00037:'只有开票状态为正常才允许作废。',
        M00038:'输入的票据号不存在于系统中，请验证！',
        M00039:'输入的{0}已存在，不能重复！',
        M00040:'{0},保存失败！'
},
    getMsg: function(code, params1, params2, params3, params4){
        var message = MsgConstants.msg[code];
        return message.format(params1, params2, params3, params4);
    }
}


