package com.xzg56.finance.common.domain.impl;


import com.xzg56.finance.bill.model.BillExportDataJgModel;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.common.domain.IBillJgDomain;
import com.xzg56.finance.common.model.BillExportJgModel;
import com.xzg56.finance.common.persistence.dao.BillHeaderJgDao;
import com.xzg56.utility.NumberUtils;
import com.xzg56.utility.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lai_hanzhang on 2017/4/24.
 */
@Component
public class BillJgDomainImpl implements IBillJgDomain {

    @Resource
    public BillHeaderJgDao billHeaderJgDao;

    @Override
    public HSSFWorkbook getExportFile(BillExportJgModel billExportJgData) {

        // 提取原始数据
        List<BillExportDataJgModel> oriResultList = findFeeAccountList(billExportJgData);
        // 提取费用名称数据
        List<BillExportDataJgModel> piList = getPiInfo(oriResultList, billExportJgData);

        //费用有效map
        LinkedHashMap<String, Object> feeMap = new LinkedHashMap<String, Object>();
        initFeeMap(feeMap, piList);
        // 提取原始数据groupBy数据
        List<LinkedHashMap<String, Object>> finalResultList = getFeeAccountRealList(oriResultList);

        // 1.2 处理数据
        finalResultList = doFinalData(oriResultList, piList, finalResultList, billExportJgData, feeMap);

        //去除无效列
        deleteColumn(feeMap, finalResultList, piList);

        // 1.3导出
        return exportExcel(finalResultList, billExportJgData, feeMap);

    }

    private void deleteColumn(LinkedHashMap<String, Object> feeMap,
                              List<LinkedHashMap<String, Object>> finalResultList, List<BillExportDataJgModel> piList) {
        for (LinkedHashMap<String, Object> tempMap : finalResultList) {
            for (BillExportDataJgModel billExportDataModel : piList) {
                if (feeMap.get(billExportDataModel.getPiCode()) != null) {
                    if (StringUtils.equals(BizFcConstants.NO, feeMap.get(billExportDataModel.getPiCode()).toString())) {
                        tempMap.remove(billExportDataModel.getPiCode());
                    }
                }
            }
            if (StringUtils.equals(BizFcConstants.NO, feeMap.get("rSum").toString())) {
                tempMap.remove("rSum");
            }
            if (StringUtils.equals(BizFcConstants.NO, feeMap.get("pSum").toString())) {
                tempMap.remove("pSum");
            }
        }


    }

    private void initFeeMap(LinkedHashMap<String, Object> feeMap, List<BillExportDataJgModel> piList) {
        for (BillExportDataJgModel billExportDataModel : piList) {
            feeMap.put(billExportDataModel.getPiCode(), "N");
        }
        feeMap.put("rSum", "N");
        feeMap.put("pSum", "N");
    }

    /**
     * 拼接费用数组
     *
     * @param oriResultList
     * @param BillExportData
     * @return
     */
    public List<BillExportDataJgModel> getPiInfo(List<BillExportDataJgModel> oriResultList, BillExportJgModel BillExportData) {
        // 费用列表Map索引用
        LinkedHashMap<String, Object> indexMap = new LinkedHashMap<String, Object>();
        int index = 0;
        // 费用List
        List<BillExportDataJgModel> piList = new ArrayList<BillExportDataJgModel>();

        // 临时FinanceModel
        BillExportDataJgModel tempModel = new BillExportDataJgModel();

        String key = "";

        for (int i = 0; i < oriResultList.size(); i++) {
            tempModel = oriResultList.get(i);
            key = tempModel.getPiCode();
            if (indexMap.get(key) == null) {
                // 将订单号和往来单位拼接成一个新key，并保存下标，索引用
                indexMap.put(key, index++);
                // 存放费用信息
                BillExportDataJgModel billExportDataModel = new BillExportDataJgModel();
                billExportDataModel.setPiCode(tempModel.getPiCode());
                billExportDataModel.setPiName(tempModel.getPiName());
                billExportDataModel.setPrType(tempModel.getPrType());
                piList.add(billExportDataModel);
            }
        }
        return piList;
    }

    /**
     * 拼接最终数据
     *
     * @param oriResultList
     * @return
     */
    public List<LinkedHashMap<String, Object>> getFeeAccountRealList(List<BillExportDataJgModel> oriResultList) {
        // 原始数据groupBy列表Map索引用
        LinkedHashMap<String, Object> indexMap = new LinkedHashMap<String, Object>();
        int index = 0;
        // 最终List
        List<LinkedHashMap<String, Object>> finalResultList = new ArrayList<LinkedHashMap<String, Object>>();

        // 临时FinanceModel
        BillExportDataJgModel tempModel = new BillExportDataJgModel();
        String key = "";
        for (int i = 0; i < oriResultList.size(); i++) {
            tempModel = oriResultList.get(i);
            key = tempModel.getBlNo() + tempModel.getContnNo() + tempModel.getCompySname() + tempModel.getBillNo();
            if (indexMap.get(key) == null) {
                // 将订单号和往来单位拼接成一个新key，并保存下标，索引用
                indexMap.put(key, index++);
                // 最终数据map
                LinkedHashMap<String, Object> finalMap = new LinkedHashMap<String, Object>();
                finalMap.put("BILL_NO", tempModel.getBillNo());
                finalMap.put("DIRECT_FLAG", tempModel.getDirectFlag());
                finalMap.put("COMPY_SNAME", tempModel.getCompySname());
                finalMap.put("ORDER_NO", tempModel.getOrderNo());
                finalMap.put("OCCUR_DATE", tempModel.getOccurDate());
                finalMap.put("BL_NO", tempModel.getBlNo());
                finalMap.put("CONTN_NO", tempModel.getContnNo());
                finalMap.put("CONTAINER_TYPE", tempModel.getContainerType());
                finalMap.put("COMMENTS", tempModel.getComments());
                finalResultList.add(finalMap);
            }
        }
        return finalResultList;
    }

    public List<LinkedHashMap<String, Object>> doFinalData(List<BillExportDataJgModel> oriResultList,
                                                           List<BillExportDataJgModel> piList, List<LinkedHashMap<String, Object>> finalResultList,
                                                           BillExportJgModel billExportData, LinkedHashMap<String, Object> feeMap) {
        // finalResultList索引用
        LinkedHashMap<String, Object> indexMap = new LinkedHashMap<String, Object>();
        // 获取finalResultList的一行数据
        LinkedHashMap<String, Object> tempFinalDataMap;
        // excel第一行
        LinkedHashMap<String, Object> firstRealMap = new LinkedHashMap<String, Object>();
        // excel统计行
        LinkedHashMap<String, Object> lastRealMap = new LinkedHashMap<String, Object>();
        DecimalFormat df = new DecimalFormat("######0.00");// 格式化用
        int index = 0;// 索引用
        String key;// 保存finalResultList当前行主key
        String piCodeTemp = "";// 存放临时piCode
        // 第一行初始化
        firstRealMap = initFirstRow(firstRealMap, piList);
        // 统计行初始化
        lastRealMap = initLastRow(lastRealMap, piList);

        // 处理了finalResultList的ID和ORDER_BY_SEQ，并拼接piList的费用信息数据，初始值0.00
        for (int i = 0; i < finalResultList.size(); i++) {
            indexMap.put(finalResultList.get(i).get("BL_NO").toString() + finalResultList.get(i).get("CONTN_NO").toString()
                    + finalResultList.get(i).get("COMPY_SNAME") + finalResultList.get(i).get("BILL_NO"), i);
            // 构建ID
            finalResultList.get(i).put("ID", i + 1);
            for (BillExportDataJgModel pi : piList) {
                // 费用初始化为0.00
                finalResultList.get(i).put(pi.getPiCode(), "0.00");
            }
            finalResultList.get(i).put("rSum", "0.00");
            finalResultList.get(i).put("pSum", "0.00");
        }

        // 循环插入数据
        for (BillExportDataJgModel fm : oriResultList) {
            // 拼接oriResultList的key
            key = (fm.getBlNo() + fm.getContnNo() + fm.getCompySname()).toString() + fm.getBillNo();

            // 根据key获取当前费用信息的下标
            index = Integer.parseInt(indexMap.get(key).toString());
            // 根据下标获取当前费用信息
            tempFinalDataMap = finalResultList.get(index);
            // 删除排序列
            tempFinalDataMap.remove("ORDER_BY_SEQ");
            // 各个费用金额累计
            piCodeTemp = fm.getPiCode();

            tempFinalDataMap.put(
                    piCodeTemp,
                    df.format(Double.parseDouble(tempFinalDataMap.get(piCodeTemp).toString())
                            + Double.parseDouble(fm.getAmount())));
            if (Double.parseDouble(fm.getAmount()) != 0) {
                feeMap.put(piCodeTemp, BizFcConstants.YES);
                if (fm.getPiCode().startsWith("2")) {
                    feeMap.put("pSum", BizFcConstants.YES);
                }
                if (fm.getPiCode().startsWith("1")) {
                    feeMap.put("rSum", BizFcConstants.YES);
                }
            }
            // 统计行金额累计
            lastRealMap.put(
                    piCodeTemp,
                    df.format(Double.parseDouble(lastRealMap.get(piCodeTemp).toString())
                            + Double.parseDouble(fm.getAmount())));
            // 如果是应付费用，则累加当前行的应付总计及统计行应付总计
            if (fm.getPiCode().startsWith("2")) {
                tempFinalDataMap.put(
                        "pSum",
                        df.format(Double.parseDouble(tempFinalDataMap.get("pSum").toString())
                                + Double.parseDouble(fm.getAmount())));
                lastRealMap.put(
                        "pSum",
                        df.format(Double.parseDouble(lastRealMap.get("pSum").toString())
                                + Double.parseDouble(fm.getAmount())));
            }
            // 如果是应收费用，则累加当前行的应收总计及统计行应收总计
            if (fm.getPiCode().startsWith("1")) {
                tempFinalDataMap.put(
                        "rSum",
                        df.format(Double.parseDouble(tempFinalDataMap.get("rSum").toString())
                                + Double.parseDouble(fm.getAmount())));
                lastRealMap.put(
                        "rSum",
                        df.format(Double.parseDouble(lastRealMap.get("rSum").toString())
                                + Double.parseDouble(fm.getAmount())));
            }
        }

        finalResultList.add(0, firstRealMap);
        finalResultList.add(lastRealMap);
        return finalResultList;
    }

    private LinkedHashMap<String, Object> initLastRow(LinkedHashMap<String, Object> lastRealMap,
                                                      List<BillExportDataJgModel> piList) {
        lastRealMap.put("ID", "");
        lastRealMap.put("BILL_NO", "");
        lastRealMap.put("DIRECT_FLAG", "");
        lastRealMap.put("OCCUR_DATE", "");
        lastRealMap.put("BL_NO", "");
        lastRealMap.put("CONTN_NO", "");
        lastRealMap.put("CONTAINER_TYPE", "合计");
        lastRealMap.put("COMMENTS", "");

        for (BillExportDataJgModel pi : piList) {
            lastRealMap.put(pi.getPiCode(), "0.00");
        }
        lastRealMap.put("rSum", "0.00");
        lastRealMap.put("pSum", "0.00");
        return lastRealMap;
    }

    private LinkedHashMap<String, Object> initFirstRow(LinkedHashMap<String, Object> firstRealMap,
                                                       List<BillExportDataJgModel> piList) {
        firstRealMap.put("ID", "序号");
        firstRealMap.put("BILL_NO", "账单号");
        firstRealMap.put("DIRECT_FLAG", "分类");
        firstRealMap.put("OCCUR_DATE", "发生时间");
        firstRealMap.put("BL_NO", "提单号");
        firstRealMap.put("CONTN_NO", "柜号");
        firstRealMap.put("CONTAINER_TYPE", "箱型");

        for (BillExportDataJgModel piInfo : piList) {
            if (piInfo.getPiCode() == null) {
                continue;
            }
            if (piInfo.getPiCode().startsWith("1"))
                firstRealMap.put(piInfo.getPiCode(), piInfo.getPiName());
        }
        firstRealMap.put("rSum", "应收-合计");
        for (BillExportDataJgModel piInfo : piList) {
            if (piInfo.getPiCode() == null)
                continue;
            if (piInfo.getPiCode().startsWith("2"))
                firstRealMap.put(piInfo.getPiCode(), piInfo.getPiName());
        }
        firstRealMap.put("pSum", "应付-合计");
        for (BillExportDataJgModel piInfo : piList) {
            if (piInfo.getPiCode() == null) {
                firstRealMap.put(piInfo.getPiCode(), "缺失相关费用");
            }
        }
        firstRealMap.put("COMMENTS", "备注");
        return firstRealMap;
    }

    public HSSFWorkbook exportExcel(List<LinkedHashMap<String, Object>> finalResultList,
                                    BillExportJgModel billExportDataModel, LinkedHashMap<String, Object> feeMap) {
        boolean rFlag = true;
        boolean pFlag = true;
        Integer rIndex = 0;
        Integer pIndex = 0;
        String relatedCompy = billExportDataModel.getRelatedCompyExecel();
        HashMap<String, String> excelMap = new HashMap<String, String>();
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("对账信息导出数据");
        sheet.setColumnWidth(0, 8 * 256);
        // 设置默认列宽度
        sheet.setDefaultColumnWidth(15);
        // 设置字体样式宋体10
        HSSFFont font_SimSun_10 = workbook.createFont();
        font_SimSun_10.setFontHeightInPoints((short) 10);
        font_SimSun_10.setFontName("宋体");
        font_SimSun_10.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

        HSSFFont font_SimSun_Red_10 = workbook.createFont();
        font_SimSun_Red_10.setFontHeightInPoints((short) 10);
        font_SimSun_Red_10.setFontName("宋体");
        font_SimSun_Red_10.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        font_SimSun_Red_10.setColor(HSSFColor.RED.index);

        // 设置字体样式宋体10
        HSSFFont font_SimSun_BOLD_10 = workbook.createFont();
        font_SimSun_BOLD_10.setFontHeightInPoints((short) 10);
        font_SimSun_BOLD_10.setFontName("宋体");
        font_SimSun_BOLD_10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        // 设置字体楷体14
        HSSFFont font_KaiTi_14__Bold = workbook.createFont();
        font_KaiTi_14__Bold.setFontHeightInPoints((short) 14);
        font_KaiTi_14__Bold.setFontName("楷体_GB2312");
        font_KaiTi_14__Bold.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        // 设置题头样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font_KaiTi_14__Bold);
        // 设置文本样式和字体
        HSSFCellStyle style = workbook.createCellStyle();
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.setFont(font_SimSun_10);
        HSSFCellStyle title = workbook.createCellStyle();
        title.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        title.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        title.setBorderRight(HSSFCellStyle.BORDER_THIN);
        title.setBorderTop(HSSFCellStyle.BORDER_THIN);
        title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        title.setFont(font_SimSun_10);
        HSSFCellStyle styleBgColorYellow = workbook.createCellStyle();
        styleBgColorYellow.setFillForegroundColor(HSSFColor.YELLOW.index);
        styleBgColorYellow.setFillPattern(CellStyle.SOLID_FOREGROUND);
        styleBgColorYellow.setBorderTop(HSSFCellStyle.BORDER_THIN);
        styleBgColorYellow.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        styleBgColorYellow.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        HSSFCellStyle styleBgColorGreen = workbook.createCellStyle();
        styleBgColorGreen.setFillForegroundColor(HSSFColor.BRIGHT_GREEN.index);
        styleBgColorGreen.setFillPattern(CellStyle.SOLID_FOREGROUND);
        styleBgColorGreen.setBorderTop(HSSFCellStyle.BORDER_THIN);
        styleBgColorGreen.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        styleBgColorGreen.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        HSSFCellStyle amount = workbook.createCellStyle();
        amount.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        amount.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        amount.setBorderRight(HSSFCellStyle.BORDER_THIN);
        amount.setBorderTop(HSSFCellStyle.BORDER_THIN);
        amount.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        amount.setFont(font_SimSun_10);
/*		HSSFDataFormat format = workbook.createDataFormat();
        amount.setDataFormat(format.getFormat("#,##0.00"));*/
        //amount.setDataFormat((short) 2);

        HSSFCellStyle blank = workbook.createCellStyle();
        blank.setBorderBottom(HSSFCellStyle.BORDER_NONE);
        blank.setBorderLeft(HSSFCellStyle.BORDER_NONE);
        blank.setBorderRight(HSSFCellStyle.BORDER_NONE);
        blank.setBorderTop(HSSFCellStyle.BORDER_NONE);
        blank.setFont(font_SimSun_10);

        HSSFCellStyle fromStyle = workbook.createCellStyle();
        // 从数据库找出表头表尾文字
        List<BillExportDataJgModel> excelTextList = billHeaderJgDao.findExcelText();
        for (BillExportDataJgModel a : excelTextList) {
            excelMap.put(a.getExcelTextCode(), a.getExcelTextvalue());
        }
        // 生成题头行
        HSSFRow row;
        HSSFCell cell;
        // HSSFRichTextString text = null;
        int rowIndex = 4;
        int lastNum = finalResultList.get(0).size();
        sheet.createFreezePane(0, rowIndex + 1, 0, rowIndex + 1);// 冻结窗口
        String textVal = null;
        int beginColumn = 6;
        int lastColumn = lastNum - 1;
        String contnDate = "";


        contnDate = finalResultList.get(finalResultList.size() - 1).get("OCCUR_DATE").toString();
        for (HashMap<String, Object> obj : finalResultList) {
            row = sheet.createRow(rowIndex);
            rowIndex++;
            for (int i = 0; i < lastNum; i++) {
                Object data = finalResultList.get(0).keySet().toArray()[i];
                if (data == null)
                    continue;
                if ("ORDER_BY_SEQ".equals(data.toString()))
                    continue;

                cell = row.createCell(i);
                if (obj.get(data) == null) {
                    textVal = "";
                } else {
                    textVal = obj.get(data).toString();
                }
                cell.setCellStyle(style);

                // 应收应付样式
                if (i > beginColumn && i < lastColumn) {
                    if (rowIndex > 5 && rowIndex <= finalResultList.size() + 4) {
                        textVal = obj.get(data).toString();
                        try {
                            double money = NumberUtils.parseDouble(textVal);
                            if (money == 0 && rowIndex < finalResultList.size() + 4) {
                                textVal = "";
                            } else {
                                textVal = money + "";
                            }
                        } catch (IllegalArgumentException e) {
                            cell.setCellValue(textVal);
                        } finally {
                            cell.setCellStyle(amount);
                        }
                    }

                } else if (data.toString().indexOf("ID") != -1) {
                    cell.setCellStyle(style);

                } else {
                    cell.setCellStyle(style);
                }

                if (rowIndex == 5) {
                    cell.setCellStyle(title);
                    if (i > beginColumn && i < lastColumn) {
                        if (data.toString().toLowerCase().startsWith("1") || data.toString().toLowerCase().startsWith("r"))
                            cell.setCellStyle(styleBgColorYellow);
                        else
                            cell.setCellStyle(styleBgColorGreen);

                        if (data.toString().startsWith("1") && rFlag) {
                            rIndex = i;
                            rFlag = false;
                        }
                        if (data.toString().startsWith("2") && pFlag) {
                            pIndex = i;
                            pFlag = false;
                        }
                    }
                }
                if (rowIndex == finalResultList.size() + 4 && i < beginColumn) {
                    cell.setCellStyle(blank);
                }
                if (i > beginColumn && i < lastColumn) {
                    if (rowIndex > 5 && rowIndex <= finalResultList.size() + 4) {
                        if (NumberUtils.isNumber(textVal)) {
                            HSSFDataFormat df = workbook.createDataFormat(); // 此处设置数据格式
                            amount.setDataFormat(df.getBuiltinFormat("###.##"));
                            cell.setCellStyle(amount);
                            cell.setCellValue(NumberUtils.toDouble(textVal));
                        } else {
                            cell.setCellValue(textVal);
                        }
                    } else {
                        cell.setCellValue(textVal);
                    }
                } else {
                    cell.setCellValue(textVal);
                }
            }

        }
        // 筛选
        sheet.setAutoFilter(new CellRangeAddress(4, 4, 0, lastNum - 1));
        // 自适应
        int remarksIndex = lastNum - 2;
        for (int i = 0; i < lastNum + 1; i++) {
            if (i == remarksIndex)
                continue;
            sheet.autoSizeColumn((short) i);
        }

        // 增加表头、表尾
        row = sheet.createRow(0);
        cell = row.createCell(0);
        fromStyle.setFont(font_SimSun_10);
        cell.setCellStyle(fromStyle);
        cell.setCellValue("");
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 15));
        row = sheet.createRow(2);
        row.setHeight((short) (50 * 15));
        String excelTitle = excelMap.get("excelTitle");
        cell = row.createCell(1);
        cell.setCellStyle(titleStyle);
        cell.setCellValue(excelTitle);
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 1, 13));
        row = sheet.createRow(3);
        row.setHeight((short) (50 * 10));

        if (contnDate == null || contnDate.equals("")) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd ");
            Date date = new Date();
            contnDate = dateFormat.format(date);
        } else {
            contnDate = StringUtils.replace(contnDate, "-", ".");
        }
        StringBuilder titleSub = new StringBuilder();
        if (relatedCompy == null || relatedCompy.equals("")) {
            relatedCompy = "";
        } else {
            relatedCompy = finalResultList.get(1).get("COMPY_SNAME").toString();
        }
        titleSub.append(excelMap.get("excelTitleSub1")).append(contnDate).append("   ")
                .append(excelMap.get("excelTitleSub2")).append(relatedCompy);
        cell = row.createCell(1);
        HSSFCellStyle infoStyle = workbook.createCellStyle();
        infoStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        infoStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        infoStyle.setFont(font_SimSun_BOLD_10);


        cell.setCellStyle(infoStyle);
        cell.setCellValue(titleSub.toString());

        if (rIndex != 0) {
            cell = row.createCell(rIndex);
            cell.setCellStyle(blank);
            cell.setCellValue("应收");
        }
        if (pIndex != 0) {
            cell = row.createCell(pIndex);
            cell.setCellStyle(blank);
            cell.setCellValue("应付");
        }


        HSSFCellStyle tipsStyle = workbook.createCellStyle();
        tipsStyle.setFont(font_SimSun_10);

        HSSFCellStyle tipsRedStyle = workbook.createCellStyle();
        tipsRedStyle.setFont(font_SimSun_Red_10);


        String tips = excelMap.get("tips1") + "\n" + excelMap.get("tips2")
                + "\n\n" + excelMap.get("tips3") + "\n" + excelMap.get("tips4");
        String[] stringArr = tips.split("\n");
        Integer indexTips = 0;
        for (String str : stringArr) {
            rowIndex++;
            indexTips++;
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 10));
            row = sheet.createRow(rowIndex);
            cell = row.createCell(0);
            cell.setCellValue(str);
            cell.setCellStyle(tipsStyle);
            if (indexTips > 2) {
                cell.setCellStyle(tipsRedStyle);
            }
        }
        HSSFCellStyle bankAccountStyle = workbook.createCellStyle();
        bankAccountStyle.setFont(font_SimSun_10);
        String bankAccount = excelMap.get("bankAccount");
        stringArr = bankAccount.split("\n");

        rowIndex++;
        for (String str : stringArr) {
            rowIndex++;
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 6));
            row = sheet.createRow(rowIndex);
            cell = row.createCell(0);
            cell.setCellValue(str);
            cell.setCellStyle(bankAccountStyle);
        }
        return workbook;
        // 结束增加表头、表尾

    }


    public List<BillExportDataJgModel> findFeeAccountList(BillExportJgModel billExportJgModel) {
        return billHeaderJgDao.findFeeAccountList(billExportJgModel);
    }
}
