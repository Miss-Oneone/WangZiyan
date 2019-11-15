package com.xzg56.jg.modules.common.domain;

import com.xzg56.jg.modules.common.persistence.entity.Attachment;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * The interface Attatchment domain.
 *
 * @author zhoushengping
 * @date 2019 /6/26
 */
public interface IAttatchmentDomain {

    /**
     * Upload file attachment.
     *
     * @param file           the file
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the attachment
     * @throws IOException the io exception
     */
    Attachment upload(MultipartFile file, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Upload file attachment.
     *
     * @param file           the file
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the attachment
     * @throws IOException the io exception
     */
    Attachment upload(File file, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Upload file attachment.
     *
     * @param file           the file
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param originalFileName the file originalFileName
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the attachment
     * @throws IOException the io exception
     */
    Attachment upload(InputStream file, String funcType, String dirName, String originalFileName, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Upload files list.
     *
     * @param files          the files
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the list
     * @throws IOException the io exception
     */
    List<Attachment> upload(MultipartFile[] files, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Upload files list.
     *
     * @param files          the files
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the list
     * @throws IOException the io exception
     */
    List<Attachment> upload(File[] files, String funcType, String dirName, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Upload files list.
     *
     * @param files          the files
     * @param funcType       the func type
     * @param dirName        the dir name
     * @param originalFileNames the file originalFileNames
     * @param prefixFileName the prefix file name
     * @param suffixFilename the suffix filename
     * @return the list
     * @throws IOException the io exception
     */
    List<Attachment> upload(InputStream[] files, String funcType, String dirName, List<String> originalFileNames, String prefixFileName, String suffixFilename) throws IOException;

    /**
     * Del attatchment by id.
     *
     * @param id the id
     */
    void delById(String id);
}
