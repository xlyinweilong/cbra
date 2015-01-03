/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cbra.web.support;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.imageio.ImageIO;

/**
 *
 * @author koala
 */
public class RandomGraphic {
    //code height and width
    private int wordHeight = 10;
    private int wordWidth = 18;
    //code size
    private int fontSize = 25;
    //code max count
    private  static final int MAX_CHARCOUNT = 16;
    
    //vertical and initial point
    private final int initypos = 5;
    
    
    //code count,use factory method
    private int charCount = 0;
    
    //code color
    private static final Color[] CHAR_COLOR = {Color.decode("#000000")};
    
    private Random r = new Random();
    
    //image type JPEG(.jpg)
    public static String GRAPHIC_JPEG = "JPEG";
    
    //image type PNG(.png)
    public static String GRAPHIC_PNG = "PNG";
    

    protected RandomGraphic(int charCount){
        this.charCount = charCount;
    }
    
    /**
     * factory method
     * @param charCount code count between 1 and 16
     *
     * Return RandomGraphic
     * @throws Exception  trows charCount exception
     */
    public static RandomGraphic createInstance(int charCount) throws Exception{
        if (charCount < 1 || charCount > MAX_CHARCOUNT){
            throw new Exception("Invalid parameter charCount,charCount should between in 1 and 16");
        }
        return new RandomGraphic(charCount);
    }
    
    
    /**
     * generate random code and print out as image type
     *
     * @param graphicFormat  set image type, value is GRAPHIC_JPEG or GRAPHIC_PNG
     * @param out
     * @return  code string generated random
     * @throws IOException
     */
    public String drawNumber(String graphicFormat,OutputStream out) throws IOException{
        String charValue = "";
        charValue = randNumber();
        return draw(charValue,graphicFormat,out);
        
    }
    
    /**
     * generate random code and print out as image type
     *
     * @param graphicFormat  set image type, value is GRAPHIC_JPEG or GRAPHIC_PNG
     * @param out
     * @return  code string generated random
     * @throws IOException
     */
    public String drawAlpha(String graphicFormat,OutputStream out) throws IOException{
        String charValue = "";
        charValue = randAlpha();
        return draw(charValue,graphicFormat,out);
        
    }
    
    
    /**
     * print out string as image
     * @param charValue  string need to print
     * @param graphicFormat set image type ,GRAPHIC_JPEG或GRAPHIC_PNG
     * @param out
     * @return
     * @throws IOException
     */
    protected String draw(String charValue,String graphicFormat,OutputStream out) throws IOException{
        
        //compute image width and height
        int w = (charCount+2) * wordWidth;
        int h = (wordHeight) * 4;
        
        //create image buffer region
        BufferedImage bi = new BufferedImage(w,h,BufferedImage.TYPE_3BYTE_BGR);
        Graphics2D g = bi.createGraphics();
        
        //set background color
        Color backColor = Color.decode("#FFFFFF");
        g.setColor(backColor);
        g.drawRect(0,0,w-1,h-1);
        g.fillRect(0,0,w,h);
        
        Color lineColor = Color.decode("#000000");
        g.setColor( lineColor );
        
        g.drawLine(0, 0, 0, h - 1);
        g.drawLine(w - 1, 0, w - 1, h - 1);
        g.drawLine(0, 0, w - 1, 0);
        g.drawLine(0, h - 1, w - 1, h - 1);
        // DRAW '---' LINE
        int widthCount = randomInt(4, 8);
        int widthStep = h / widthCount;
        int y = 0;
        for (int i = 0; i < widthCount; i++) {
            y = randomInt(Math.max(widthStep * i, y + widthStep / 2), Math.min(widthStep * (i + 1), h - widthStep / 2));
            g.drawLine(0, y, w - 1, y);
        }
        
        // DRAW '|' LINE
        int heightCount =  randomInt(10, 15);
        int heightStep = w / heightCount;
        int x = 0;
        for (int i = 0; i < heightCount; i++) {
            x = randomInt(Math.max(heightStep * i, x + heightStep / 2), Math.min(heightStep * (i + 1), w - heightStep / 2));
            g.drawLine(x, 0, x, h - 1);
        }
        
        //set font
        g.setFont(new Font(null,Font.BOLD+Font.ITALIC,fontSize));
        //print out charValue
        for(int i = 0; i < charCount; i++){
            String c = charValue.substring(i,i+1);
            Color color =  CHAR_COLOR[randomInt(0,CHAR_COLOR.length)];
            g.setColor(color);
            int xpos = (i+1) * wordWidth;
            //vetical and initial random  point
            int ypos = randomInt(initypos+wordHeight * 2,initypos+wordHeight*3);
            g.drawString(c,xpos,ypos);
        }
        g.dispose();
        bi.flush();
        
        ImageIO.write(bi,graphicFormat,out);
        
        return charValue;
    }
    
    protected String randNumber(){
        String charValue = "";
        //generate number string
        for (int i = 0; i < charCount; i++){
            charValue += String.valueOf(randomInt(0,10));
        }
        return charValue;
    }
    
    
    //@return return an alpha between A and Z
    
    private String randAlpha(){
        String charValue = "";
        //generate alpha string
        for (int i = 0; i < charCount; i++){
            char c = (char) (randomInt(0,26)+'A');
            charValue += String.valueOf(c);
        }       
        return charValue;
    }
    
    
    
    /**
     * return a number between [from,to]
     *
     * @param from start number
     * @param to end number
     * @return
     */
    protected int randomInt(int from,int to){
        //Random r = new Random();
        return from+r.nextInt(to-from);
    }
    
    
    
    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        
        System.out.println(RandomGraphic.createInstance(4).drawAlpha(RandomGraphic.GRAPHIC_PNG,new FileOutputStream("c:/myimg.png")));
        
        
    }
    
}
