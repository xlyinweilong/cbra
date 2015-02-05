/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.support.Tools;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.ejb.Asynchronous;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.text.StrMatcher;
import org.apache.commons.lang.text.StrTokenizer;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.apache.commons.validator.EmailValidator;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.exception.MethodInvocationException;
import org.apache.velocity.exception.ParseErrorException;
import org.apache.velocity.exception.ResourceNotFoundException;

/**
 * 邮件服务器
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class EmailService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    @Resource(name = "cbra_mailsession")
    private Session mailsession;
    // template engine
    VelocityEngine velocityEngine = new VelocityEngine();
    // email from,subject,content charactor encoding
    private final String emailCharset = "GBK";
    private final Logger logger = Logger.getLogger(EmailService.class.getName());

    public EmailService() {
        initVelocityEngine();
    }

    private void initVelocityEngine() {
        velocityEngine.setProperty("resource.loader", "class");
        velocityEngine.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityEngine.setProperty("input.encoding", "UTF-8");
        velocityEngine.setProperty("output.encoding", "GB2312");
        velocityEngine.setProperty("default.contentType", "text/plain; charset=GB2312");
        try {
            velocityEngine.init();
        } catch (Exception ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<String> getValidEmailList(String rawInput) {
        LinkedList<String> list = new LinkedList<String>();
        EmailValidator emailValidator = EmailValidator.getInstance();
        // MATCHERS
        StrMatcher listDelimMatcher = StrMatcher.charSetMatcher(",;\n");
        StrMatcher addrDelimMatcher = StrMatcher.charSetMatcher("<>");
        StrMatcher quoteMatcher = StrMatcher.quoteMatcher();
        StrMatcher trimMatcher = StrMatcher.trimMatcher();
        // CUT STRING BY , OR ;
        StrTokenizer listTokenizer = new StrTokenizer(rawInput, listDelimMatcher, quoteMatcher);
        listTokenizer.setTrimmerMatcher(trimMatcher);
        while (listTokenizer.hasNext()) {
            String nextToken = listTokenizer.nextToken();
            // CUT STRING BY < OR >, // address format is "name1 name2" <email>
            StrTokenizer addrTokenizer = new StrTokenizer(nextToken, addrDelimMatcher, quoteMatcher);
            addrTokenizer.setTrimmerMatcher(trimMatcher);
            if (addrTokenizer.size() == 0) {
                // Bad string
            } else {
                String[] tokenArray = addrTokenizer.getTokenArray();
                // the last item is email, no matter how many itmes there.
                String lastItem = tokenArray[tokenArray.length - 1];
                if (emailValidator.isValid(lastItem)) {
                    list.add(lastItem);
                }
            }
        }
        return list;
    }

    /**
     * 这个方法使用Commons
     * Email里面的SimpleEmail来发送html内容的邮件，并把transfer-encoding设成base64编码。
     *
     * @param displayFromName
     * @param fromEmail
     * @param toEmail
     * @param subject
     * @param body
     * @throws EmailException
     */
    void sendSimpleEmail(String displayFromName, String fromEmail, String[] replyEmails, String toEmail, String subject, String body) throws EmailException, AddressException {
        SimpleEmail email = new SimpleEmail();
        email.setMailSession(mailsession);
        // Prepare email
        email.setCharset(emailCharset);
        email.setFrom(fromEmail, displayFromName, emailCharset);
        if (replyEmails != null && replyEmails.length > 0) {
            List<InternetAddress> replyAddressList = new ArrayList<>();
            for (String replyEmail : replyEmails) {
                InternetAddress ia = new InternetAddress(replyEmail);
                replyAddressList.add(ia);
            }
            email.setReplyTo(replyAddressList);
        }
        email.addTo(toEmail);
        email.setSubject(subject);
        email.setContent(body, "text/html; charset=" + emailCharset);
        HashMap map = new HashMap();
        map.put("Content-Transfer-Encoding", "base64");
        email.setHeaders(map);
        // build and send email
        email.buildMimeMessage();
        email.sendMimeMessage();
    }

    void sendEmailAttachment(String displayFromName, String fromEmail, String[] replyEmails, String toEmail, String subject, String body, List<String> attachs, String zipAttachName) throws EmailException, IOException {
        HtmlEmail email = new HtmlEmail();
        email.setMailSession(mailsession);
        // Prepare email
        email.setCharset(emailCharset);
        email.setFrom(fromEmail, displayFromName, emailCharset);
        if (replyEmails != null && replyEmails.length > 0) {
            email.setReplyTo(Arrays.asList(replyEmails));
        }
        email.addTo(toEmail);
        email.setSubject(subject);
        email.setHtmlMsg(body);
        //email.setContent(body, "text/html; charset=" + emailCharset);
        HashMap map = new HashMap();
        map.put("Content-Transfer-Encoding", "base64");
        email.setHeaders(map);
        // attachment
        File zipAttachment = null;
        if (attachs.size() > 4) {
            String md5 = Tools.md5(fromEmail + toEmail + System.currentTimeMillis());
            zipAttachment = new File(Config.FILE_UPLOAD_TEMP_DIR, md5 + ".zip");
            FileUtils.touch(zipAttachment);
            String absolutePath = zipAttachment.getAbsolutePath();
            Tools.zip(attachs, absolutePath);
            //
            EmailAttachment attachment = new EmailAttachment();
            attachment.setPath(absolutePath);
            attachment.setDisposition(EmailAttachment.ATTACHMENT);
            attachment.setName(zipAttachName + ".zip");
            email.attach(attachment);
        } else {
            for (int i = 0; i < attachs.size(); i++) {
                String attach = attachs.get(i);
                EmailAttachment attachment = new EmailAttachment();
                attachment.setPath(attach);
                attachment.setDisposition(EmailAttachment.ATTACHMENT);
                email.attach(attachment);
            }
        }

        // send email
        email.send();

        // delete zip file
        if (zipAttachment != null) {
            FileUtils.deleteQuietly(zipAttachment);
        }
    }

    @Asynchronous
    public void send(String displayFromName, String fromEmail, String toEmail, String subject, String templateName, Map model, List<String> attachs, String zipAttachName) {
        try {
            System.out.println("Email Sending. from=" + fromEmail + " to=" + toEmail + " templateFile=" + templateName);
            StringWriter sw = new StringWriter();
            Template template = velocityEngine.getTemplate(templateName);
            model.put("Tools", Tools.class);
            template.merge(new VelocityContext(model), sw);
            String body = sw.getBuffer().toString();
            // send
            if (attachs == null || attachs.isEmpty()) {
                sendSimpleEmail(displayFromName, fromEmail, null, toEmail, subject, body);
            } else {
                sendEmailAttachment(displayFromName, fromEmail, null, toEmail, subject, body, attachs, zipAttachName);
            }
        } catch (MethodInvocationException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ResourceNotFoundException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseErrorException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (EmailException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Asynchronous
    public void send(String displayFromName, String fromEmail, String replyEmail, String toEmail, String subject, String templateName, Map model, List<String> attachs, String zipAttachName) {
        try {
            System.out.println("Email Sending. from=" + fromEmail + " to=" + toEmail + " templateFile=" + templateName);
            StringWriter sw = new StringWriter();
            Template template = velocityEngine.getTemplate(templateName);
            model.put("Tools", Tools.class);
            template.merge(new VelocityContext(model), sw);
            String body = sw.getBuffer().toString();
            // send
            if (attachs == null || attachs.isEmpty()) {
                sendSimpleEmail(displayFromName, fromEmail, new String[]{replyEmail}, toEmail, subject, body);
            } else {
                sendEmailAttachment(displayFromName, fromEmail, new String[]{replyEmail}, toEmail, subject, body, attachs, zipAttachName);
            }
        } catch (MethodInvocationException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ResourceNotFoundException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseErrorException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (EmailException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
