/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

import cn.yoopay.support.exception.NotVerifiedException;
import java.io.*;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.mail.Flags.Flag;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.EmailValidator;
import sun.misc.BASE64Encoder;

/**
 * 工具类
 *
 * @author yin.weilong
 */
public class Tools {

    public static Map<String, Date> getAdminStartDate(Date startDate, Date endDate) {
        Map<String, Date> map = new HashMap<String, Date>();
        if (startDate == null && endDate == null) {
            startDate = Tools.getBeginOfDay(new Date());
            endDate = Tools.getEndOfDay(new Date());
        } else if (startDate != null && endDate == null) {
            startDate = Tools.getBeginOfDay(startDate);
            endDate = Tools.getEndOfDay(startDate);
        } else if (startDate == null && endDate != null) {
            startDate = Tools.getBeginOfDay(endDate);
            endDate = Tools.getEndOfDay(endDate);
        } else {
            startDate = Tools.getBeginOfDay(startDate);
            endDate = Tools.getEndOfDay(endDate);
        }
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        return map;
    }

    public static void outputServletResponse(HttpServletResponse response, String text) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println(text);
        } finally {
            out.close();
        }
    }

    public static void outputServletResponse(HttpServletResponse response, Throwable ex) throws IOException {
        String stackTrace = getStackTrace(ex);
        outputServletResponse(response, stackTrace);
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    //String tools

    public static String reverse(String str) {
        StringBuilder sb = new StringBuilder(str);
        sb.reverse();
        return sb.toString();
    }

    public static String[] getSplit(String src, String split) {
        return src.split(split);
    }

    public static void generateHTMLFile(String fileFullPath, String content) throws IOException {
        File file = new File(fileFullPath);
        FileUtils.writeStringToFile(file, content, "UTF-8");
    }
    //Format tools

    public static String getEscapedBrHtml(String str) {
        str = StringEscapeUtils.escapeHtml(str);
        str = StringUtils.replace(str, "\n", " <br/>");
        return str;
    }

    public static String getEscapedHtml(String str) {
        return StringEscapeUtils.escapeHtml(str);
    }

    public static String getUnEscapedHtml(String str) {
        return StringEscapeUtils.unescapeHtml(str);
    }

    public static String formatCurrency(Number number) {
        DecimalFormat dFormat = new DecimalFormat();
        dFormat.applyPattern("#,##0.##");
        return dFormat.format(number);
    }

    public static Number parseCurrency(String str) throws ParseException {
        DecimalFormat dFormat = new DecimalFormat();
        dFormat.applyPattern("#,##0.##");
        return dFormat.parse(str);
    }

    public static String formatCurrency(Number number, Locale locale) {
        DecimalFormat df = new DecimalFormat("¤#,###", DecimalFormatSymbols.getInstance(locale));
        return df.format(number);
    }

    /**
     * 格式化货币： 123456 --> ￥123,456
     *
     * @param number
     * @return
     */
    public static String formatRMBCurrency(Number number) {
        return formatCurrency(number, Locale.CHINA);
    }

    public static double round(double v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal("1");
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static BigDecimal round(BigDecimal bd, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal one = new BigDecimal("1");
        return bd.divide(one, scale, BigDecimal.ROUND_HALF_UP);
    }
    //Validate tools

    public static boolean isNotNullAndNotEmpty(List list) {
        if (list != null && !list.isEmpty()) {
            return true;
        }
        return false;
    }

    public static boolean isNotEmpty(String[] src) {
        if (null == src) {
            return false;
        }
        return src.length > 0 ? true : false;
    }

    public static boolean isNotBlank(String src) {
        return StringUtils.isNotBlank(src);
    }

    public static boolean isBlank(String src) {
        return StringUtils.isBlank(src);
    }

    public static boolean isNotBlankAndEqTrue(String src) {
        if (StringUtils.isBlank(src)) {
            return false;
        }
        if ("true".equalsIgnoreCase(src)) {
            return true;
        }
        return false;
    }

    public static boolean isNotNullAndGtZero(Integer target) {
        if (null == target || target.intValue() <= 0) {
            return false;
        }
        return true;
    }

    public static boolean isNotBlankAndEqStr(String src, String eq) {
        boolean result = StringUtils.isNotBlank(src);
        if (result) {
            if (!src.trim().equalsIgnoreCase(eq)) {
                result = false;
            }
        }
        return result;
    }

    public static boolean isNotBlankAndNotEqStr(String src, String eq) {
        boolean result = StringUtils.isNotBlank(src);
        if (result) {
            if (src.trim().equalsIgnoreCase(eq)) {
                result = false;
            }
        }
        return result;
    }

    public static boolean isEmail(String src) {
        return EmailValidator.getInstance().isValid(src);
    }

    public static String formatMobilePhoneNumber(String src) {
        if (Tools.isBlank(src)) {
            return null;
        }
        return src.trim().replaceAll("^\\+86|^86|[\\D]*", "");

    }

    public static boolean isEqual(String src, String... targets) {
        for (String target : targets) {
            if (src.equalsIgnoreCase(target)) {
                return true;
            }
        }
        return false;
    }
    //Date Utils

    public static Date mergeDate(Date date, String time) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String[] arrayTime = time.split(":");
        calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(arrayTime[0]));
        calendar.set(Calendar.MINUTE, Integer.parseInt(arrayTime[1]));
        return calendar.getTime();
    }

    public static Date subMinute(Date date, int minute) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MINUTE, -minute);
        return calendar.getTime();
    }

    public static Date addHour(Date date, int hour) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.HOUR_OF_DAY, hour);
        return calendar.getTime();
    }

    public static Date addDay(Date date, int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, day);
        return calendar.getTime();
    }

    public static Date addYear(Date date, int year) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.YEAR, year);
        return calendar.getTime();
    }

    static public Date getBeginOfDay(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date begin = cal.getTime();
        return begin;
    }

    static public Date getEndOfDay(Date date) {//date下一天的开始
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        cal.add(Calendar.DATE, 1);
        Date end = cal.getTime();
        return end;
    }

    public static Date getBeginOfMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        Date d = cal.getTime();
        return getBeginOfDay(d);
    }

    public static Date getEndofMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        Date end = getBeginOfMonth(date);
        cal.setTime(end);
        cal.add(Calendar.MONTH, 1);
        //cal.add(Calendar.MILLISECOND, -1);
        return cal.getTime();
    }

    public static Date parseDate(String dStr, String style) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(style);
            return sdf.parse(dStr);
        } catch (ParseException ex) {
            return null;
        }
    }

    public static String formatDate(Date date, String style) {
        SimpleDateFormat sdf = new SimpleDateFormat(style);
        return sdf.format(date);
    }

    public static String formatDate(Date date, String style, Locale locale) {
        SimpleDateFormat sdf = new SimpleDateFormat(style, locale);
        return sdf.format(date);
    }

    public static String formatDateYmdOnly(Date date, Locale locale) {
        String style = "MMMM d, yyyy";
        if (locale.getLanguage().equals("zh")) {
            style = "yyyy年M月d日";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(style, locale);
        return sdf.format(date);
    }

    public static String formatDate(Date date, String style, DateFormatSymbols dfs) {
        SimpleDateFormat sdf = new SimpleDateFormat(style, dfs);
        return sdf.format(date);
    }

    public static String formatWeekday(Date date, Locale locale) {
        if (date == null) {
            return "";
        }
        String weekPattern = "EEE";
        String today = "Today";
        String yesterday = "Yest.";
        String tomorrow = "TMRW";
        if (locale.getLanguage().equals("zh")) {
            today = "今天";
            yesterday = "昨天";
            tomorrow = "明天";
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        Calendar now = Calendar.getInstance();
        if (isSameYear(cal, now)) {
            int period = getPeriodYearDay(cal, now);
            switch (period) {
                case 1:
                    return tomorrow;
                case 0:
                    return today;
                case -1:
                    return yesterday;
            }
        }
        DateFormatSymbols dfs = new DateFormatSymbols(locale);
        if (locale.getLanguage().equals("zh")) {
            dfs.setShortWeekdays(new String[]{"", "周日", "周一", "周二", "周三", "周四", "周五", "周六"});
        }
        String result = formatDate(date, weekPattern, dfs);
        return result;
    }

    public static boolean isSameYear(Calendar c1, Calendar c2) {
        return c1.get(Calendar.YEAR) == c2.get(Calendar.YEAR);
    }

    public static boolean isSameYearDay(Calendar c1, Calendar c2) {
        return c1.get(Calendar.DAY_OF_YEAR) == c2.get(Calendar.DAY_OF_YEAR);
    }

    public static int getPeriodYearDay(Calendar c1, Calendar c2) {
        return c1.get(Calendar.DAY_OF_YEAR) - c2.get(Calendar.DAY_OF_YEAR);
    }

    public static String formatStartTimeAndEndTime(Date startDate, Date endDate, Boolean isWholeDay, Locale locale) {
        if (startDate == null || endDate == null) {
            return "";
        }
        String datePattern = isWholeDay ? "EEEE, MMMM d, yyyy" : "EEEE, MMMM d, yyyy HH:mm";
        String monthPattern = isWholeDay ? "EEEE, MMMM d" : "EEEE, MMMM d HH:mm";
        String dayPattern = isWholeDay ? "EEEE, d" : "EEEE, d HH:mm";
        //String fullDayStr = " Whole Day";
        String to = " to ";
        if (locale.getLanguage().equals("zh")) {
            datePattern = isWholeDay ? "yyyy年M月d日 EEE" : "yyyy年M月d日 EEE HH:mm";
            monthPattern = isWholeDay ? "M月d日 EEE " : "M月d日 EEE HH:mm";
            dayPattern = isWholeDay ? "d日 EEE" : "d日 EEE HH:mm";
            //fullDayStr = " 全天";
            to = " 至 ";
        }
        StringBuilder sb = new StringBuilder();
        //开始日期
        Calendar start = Calendar.getInstance();
        start.setTime(startDate);
        int startDay = start.get(Calendar.DAY_OF_YEAR);
        //结束日期
        Calendar end = Calendar.getInstance();
        end.setTime(endDate);
        int endDay = end.get(Calendar.DAY_OF_YEAR);

        if (start.get(Calendar.YEAR) == end.get(Calendar.YEAR)) {
            if (start.get(Calendar.MONTH) == end.get(Calendar.MONTH)) {
                if (startDay == endDay) {
                    //同一天中
                    sb.append(formatDate(startDate, datePattern, locale));
                    if (isWholeDay) {
                        //sb.append(fullDayStr);
                    } else {
                        sb.append(to).append(formatDate(endDate, "HH:mm"));
                    }
                } else {
                    //相同年、月，不同天中
                    sb.append(formatDate(startDate, datePattern, locale)).append(to).append(formatDate(endDate, dayPattern, locale));
                }
            } else {
                //相同年，不同月中
                sb.append(formatDate(startDate, datePattern, locale)).append(to).append(formatDate(endDate, monthPattern, locale));
            }
        } else {
            //不同年中
            sb.append(formatDate(startDate, datePattern, locale)).append(to).append(formatDate(endDate, datePattern, locale));
        }
        return sb.toString();
    }

    //Codec Utils
    public static String md5(String s) {
        try {
            s = s.toUpperCase().trim() + "CBRA";
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.update(s.getBytes(), 0, s.length());
            s = new BigInteger(1, m.digest()).toString(16);
        } catch (NoSuchAlgorithmException ex) {
        }
        return s;
    }

    //Random Utils
    public static String generateRandom10Chars() {
        return generateRandomNumber(10);
    }

    public static String generateRandom8Chars() {
        return generateRandomNumber(8);
    }

    public static String generateRandomAlpha(int length) {
        return RandomStringUtils.randomAlphabetic(length);
    }

    public static String generateRandomNumber(int length) {
        return RandomStringUtils.randomNumeric(length);
    }

    /**
     * 使用Id随即生成唯一且内容为字母数字的字符串(Random Unique Alpha Number)
     *
     * @param id
     * @return
     */
    public static String generateRandom8Chars(Long oid) {
        StringBuilder result = new StringBuilder();
        String idStr = String.valueOf(oid);
        int totalLength = 8;
        int idStrLength = idStr.length();
        int randomStrLength = totalLength - idStrLength;
        String randomStr = generateRandomAlpha(randomStrLength);
        int repate = idStrLength > randomStrLength ? randomStrLength : idStrLength;
        for (int i = 0; i < repate; i++) {
            result.append(idStr.charAt(i)).append(randomStr.charAt(i));
        }
        if (idStrLength > randomStrLength) {
            result.append(idStr.substring(repate));
        } else {
            result.append(randomStr.substring(repate));
        }
        return result.toString();
    }

    //Email Utils
    /**
     * 从一段文字中解析出email地址
     *
     * @param emails
     * @param orgiText
     */
    public static void parseEmails(Set<String> emails, String orgiText) {
        Pattern emailer = Pattern.compile("[\\w[.-]]+@[\\w[.-]]+\\.[\\w]+");
        Matcher matchr = emailer.matcher(orgiText);
        while (matchr.find()) {
            String email = matchr.group();
            emails.add(email.toLowerCase());
        }
    }

    /**
     * 获取email前缀
     *
     * @前
     *
     * @param email
     * @return
     */
    public static String getEmailPrefix(String email) {
        return email.substring(0, email.indexOf("@"));
    }

    /**
     * 屏蔽email地址
     *
     * @后内容
     *
     * @param email
     * @return
     */
    public static String shieldingEmailSuffix(String email) {
        return email.substring(0, email.indexOf("@")) + "@******";
    }

    /**
     * 银行卡号，留下前4位和后3位，其余屏蔽
     *
     * @param BankCardNumber
     * @return
     */
    public static String shieldingBankCardNumber(String BankCardNumber) {
        if (BankCardNumber.length() < 8) {
            return BankCardNumber;
        }
        return StringUtils.left(BankCardNumber, 4) + StringUtils.repeat("*", BankCardNumber.length() - 7) + StringUtils.right(BankCardNumber, 3);
    }

    /**
     * 一段的字符串留下后3位，其他全部屏蔽
     *
     * @param mobilePhone
     * @return
     */
    public static String shieldingStringForepart(String str) {
        str.trim();
        if (str.length() < 4) {
            return str;
        }
        return StringUtils.repeat("*", str.length() - 3) + StringUtils.right(str, 3);
    }

    /**
     * 获取邮件内容
     *
     * @param part
     * @param bodytext
     * @throws MessagingException
     * @throws IOException
     */
    public static void getEmailContent(Part part, StringBuilder bodytext) throws MessagingException, IOException {
        if (part.isMimeType("text/plain") && bodytext.length() < 1) {
            bodytext.append((String) part.getContent());
        } else if (part.isMimeType("text/html") && bodytext.length() < 1) {
            bodytext.append((String) part.getContent());
        } else if (part.isMimeType("multipart/*")) {
            Multipart multipart = (Multipart) part.getContent();
            int count = multipart.getCount();
            for (int i = 0; i < count; i++) {
                getEmailContent(multipart.getBodyPart(i), bodytext);
            }
        } else if (part.isMimeType("message/rfc822")) {
            getEmailContent((Part) part.getContent(), bodytext);
        }
    }

    public static String getEmailFromAddress(Message msg) throws MessagingException {
        InternetAddress[] address = (InternetAddress[]) msg.getFrom();
        String from = address[0].getAddress();
        if (from == null) {
            from = "";
        }
        return from;
    }

    public static boolean isWeekOldEmail(Message message) throws MessagingException {
        Date sendDate = message.getSentDate();
        if (sendDate == null) {
            return false;
        }
        Date nowDate = new Date();
        long d1 = sendDate.getTime();
        long d2 = nowDate.getTime();
        long diff = d2 - d1;
        long week = 7 * 24 * 3600 * 1000;
        if (diff > week) {
            return true;
        } else {
            return false;
        }
    }

    public static void deleteEmail(Message message) throws MessagingException {
        message.setFlag(Flag.DELETED, true);
    }

    public static void zip(List<String> sourceList, String destZip) throws IOException {
        List<File> list = new LinkedList<File>();
        for (int i = 0; i < sourceList.size(); i++) {
            String filename = sourceList.get(i);
            File file = new File(filename);
            list.add(file);
        }
        File destFile = new File(destZip);
        zip(list, destFile);
    }

    public static void zip(List<File> sourceList, File destZipFile) throws IOException {
        final int BUFFER = 2048;

        BufferedInputStream origin = null;
        FileOutputStream dest = new FileOutputStream(destZipFile);
        ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(dest));
        out.setMethod(ZipOutputStream.DEFLATED);
        byte data[] = new byte[BUFFER];

        for (int i = 0; i < sourceList.size(); i++) {
            File file = sourceList.get(i);
            FileInputStream fi = new FileInputStream(file);
            origin = new BufferedInputStream(fi, BUFFER);
            ZipEntry entry = new ZipEntry(file.getName());
            out.putNextEntry(entry);
            int count;
            while ((count = origin.read(data, 0, BUFFER)) != -1) {
                out.write(data, 0, count);
            }
            origin.close();
        }
        out.close();
    }

    public static boolean isInstanceof(Object sourceObject, String theClassName) {
        try {
            Class c = Class.forName(theClassName);
            if (sourceObject.getClass().equals(c)) {
                return true;
            }
            return false;
        } catch (ClassNotFoundException e) {
            return false;
        }
    }

    public static String getIpAddr(HttpServletRequest request) {
        String ipAddress = null;
        ipAddress = request.getHeader("x-forwarded-for");
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
            if (ipAddress.equals("127.0.0.1")) {
                //根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ipAddress = inet.getHostAddress();
            }
        }
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ipAddress != null && ipAddress.length() > 15) { //"***.***.***.***".length() = 15
            if (ipAddress.indexOf(",") > 0) {
                ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
            }
        }
        return ipAddress;
    }

    /**
     * 保存上传的文件
     *
     * @param item
     * @param src
     * @param filename
     */
    public static void setUploadFile(FileUploadItem item, String src, String filename) {
        try {
            String fullPath = src + filename;
            FileUtils.copyFile(new File(item.getUploadFullPath()), new File(fullPath));
            FileUtils.deleteQuietly(new File(item.getUploadFullPath()));
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        System.out.println(md5("admin"));
    }
}
