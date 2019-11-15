package com.xzg56.jg.modules.common.domain.impl;


import com.xzg56.core.config.Global;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.jg.modules.common.domain.IAttatchmentDomain;
import com.xzg56.jg.modules.common.persistence.dao.AttachmentDao;
import com.xzg56.jg.modules.common.persistence.entity.Attachment;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.FileUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author zhoushengping
 * @date 2019/6/26
 */
@Component
public class AttatchmentDomainImpl implements IAttatchmentDomain {

    @Resource
    private AttachmentDao attachmentDao;

    @Override
    public Attachment upload(MultipartFile file, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException {
        return this.insertAttachment(file.getBytes(), file.getOriginalFilename(), funcType,  dirName, prefixFileName, suffixFilename);
    }

    @Override
    public Attachment upload(File file, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException {
        return this.insertAttachment(FileUtils.readFileToByteArray(file), file.getName(), funcType,  dirName, prefixFileName, suffixFilename);
    }

    @Override
    public Attachment upload(InputStream file, String funcType, String dirName, String originalFileName, String prefixFileName, String suffixFilename) throws IOException {
        int count = 0;
        while (count == 0) {
            count = file.available();
        }
        return this.insertAttachment(new byte[file.available()], originalFileName, funcType, dirName, prefixFileName, suffixFilename);
    }

    @Override
    public List<Attachment> upload(MultipartFile[] files, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException {
        List<Attachment> list = new ArrayList<>();
        for(MultipartFile file: files) {
            list.add(this.insertAttachment(file.getBytes(), file.getOriginalFilename(), funcType,  dirName, prefixFileName, suffixFilename));
        }
        return list;
    }

    @Override
    public List<Attachment> upload(File[] files, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException {
        List<Attachment> list = new ArrayList<>();
        for(File file: files) {
            list.add(this.insertAttachment(FileUtils.readFileToByteArray(file), file.getName(), funcType,  dirName, prefixFileName, suffixFilename));
        }
        return list;
    }

    @Override
    public List<Attachment> upload(InputStream[] files, String funcType, String dirName, List<String> originalFileNames, String prefixFileName, String suffixFilename) throws IOException {
        List<Attachment> list = new ArrayList<>();
        int i = 0;
        String originalFileName = "";
        for(InputStream file: files) {
            int count = 0;
            while (count == 0) {
                count = file.available();
            }
            if(i > originalFileNames.size() - 1) {
                originalFileName = "";
            } else {
                originalFileName = originalFileNames.get(i);
            }
            list.add(this.insertAttachment(new byte[file.available()], originalFileName, funcType,  dirName, prefixFileName, suffixFilename));
            i++;
        }
        return list;
    }

    @Override
    public void delById(String attatchmentId) {
        if(StringUtils.isNotBlank(attatchmentId)) {
            Attachment attachment = attachmentDao.get(Long.parseLong(attatchmentId));
            if(attachment != null) {
                attachmentDao.delete(attachment);
            } else {
                throw new ValidationException("该附件已被删除，请刷新后确认");
            }
        }
    }

    private Attachment insertAttachment(byte[] bytes, String originalFileName, String funcType, String dirName,String prefixFileName,String suffixFilename) throws IOException {
        Attachment attachment = new Attachment();
        // 拼接存储文件名
        StringBuffer fileName = new StringBuffer();
        if (StringUtils.isNotBlank(prefixFileName)) {
            fileName.append(prefixFileName).append("_");
        }
        fileName.append(UUID.randomUUID()).append(suffixFilename);

        if(StringUtils.isBlank(originalFileName)) {
            originalFileName = fileName.toString();
        }
        attachment.setName(originalFileName);

        String path = this.saveFile(bytes,funcType,dirName,fileName.toString());
        attachment.setUrl(path);

        attachmentDao.insert(attachment);

        return attachment;
    }

    /**
     * 保存附件
     *
     * @param bytes  附件字节数组
     * @param funcType 附件功能类型
     * @param dirName 子文件名
     * @param fileName 文件名
     * @return
     * @throws IOException
     */
    private String saveFile(byte[] bytes, String funcType, String dirName, String fileName) throws IOException {


        // 拼接文件存储路径
        String uploadPath = Global.getConfig("uploadPath");
        String currentDate = DateUtils.getDate();
        StringBuffer uploadPathSb = new StringBuffer();
        uploadPathSb.append(uploadPath);
        if(!StringUtils.endsWith( uploadPath, "/") && !StringUtils.endsWith( uploadPath, "\\")) {
            uploadPathSb.append("/");
        }
        uploadPathSb.append(funcType);
        uploadPathSb.append("/");
        uploadPathSb.append(currentDate);
        uploadPathSb.append("/");
        if(StringUtils.isNotBlank(dirName)) {
            uploadPathSb.append(dirName);
            uploadPathSb.append("/");
        }
        uploadPathSb.append(fileName.toString());
        uploadPath = uploadPathSb.toString();

        File folder = new File(uploadPath);
        File dir = folder.getParentFile();
        if(!dir.isFile()){
            dir.mkdirs();
        }

        FileOutputStream out = new FileOutputStream(uploadPath);
        IOUtils.write(bytes, out);
        IOUtils.closeQuietly(out);

        String fileServer = Global.getConfig("fileServer");
        StringBuffer path = new StringBuffer();
        path.append(fileServer);
        if(!StringUtils.endsWith( fileServer, "/") && !StringUtils.endsWith( fileServer, "\\")) {
            path.append("/");
        }
        path.append(funcType);
        path.append("/");
        path.append(currentDate);
        path.append("/");
        if(StringUtils.isNotBlank(dirName)) {
            path.append(dirName);
            path.append("/");
        }
        path.append(fileName);

        return path.toString();
    }
}
