package com.xzg56.jg.modules.mst.bankAccount.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by wjn on 2019/03/26
 */

public class BankAccountModel extends IdEntity<BankAccountModel> {

    private static final long serialVersionUID = -8222201133768563150L;
    /**
     * 银行账号
     */
    private String accountNo;
    /**
     * 账户名称
     */
    private String accountName;
    /**
     * 开户行(支行)
     */
    private String bankBranch;
    /**
     * 开户行(总行)
     */
    private String bank;
    /**
     * 余额(人民币)
     */
    private String amountRmb;
    /**
     * 余额(美元)
     */
    private String amountUs;

    /**
     * 日记帐前缀
     */
    private String cjNoPrefix;
    /**
     *对公标志
     */
    private String publicSign;

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getBankBranch() {
        return bankBranch;
    }

    public void setBankBranch(String bankBranch) {
        this.bankBranch = bankBranch;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getAmountRmb() {
        return amountRmb;
    }

    public void setAmountRmb(String amountRmb) {
        this.amountRmb = amountRmb;
    }

    public String getAmountUs() {
        return amountUs;
    }

    public void setAmountUs(String amountUs) {
        this.amountUs = amountUs;
    }

    public String getCjNoPrefix() {
        return cjNoPrefix;
    }

    public void setCjNoPrefix(String cjNoPrefix) {
        this.cjNoPrefix = cjNoPrefix;
    }

    public String getPublicSign() {
        return publicSign;
    }

    public void setPublicSign(String publicSign) {
        this.publicSign = publicSign;
    }
}
