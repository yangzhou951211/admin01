package com.shsxt.test;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

/**
 * 二维码测试类
 * @author 王东海
 * @2016年11月18日
 */
public class QrcodeTest
{
	public static void main(String[] args) throws Exception
	{
		String content = "小陈林成就大梦想!!!";
		//创建二维码对象
		Qrcode qrcode = new Qrcode();
		//设置二维码的纠错级别L(7%) M(15%) Q(25%) H(30%)
		qrcode.setQrcodeErrorCorrect('M');
		//设置二维码的编码方式:Binary
		qrcode.setQrcodeEncodeMode('B');
		//设置二维码的版本号1-40 二维码尺寸
		qrcode.setQrcodeVersion(15);
		
		//创建画板
		int width = 255;
		int height = 255;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		//创建画笔
		Graphics2D graphics2d = image.createGraphics();
		//设置背景颜色为白颜色
		graphics2d.setBackground(Color.WHITE);
		//设置画笔颜色为黑颜色
		graphics2d.setColor(Color.BLACK);
		//清空矩形
		graphics2d.clearRect(0, 0, width, height);
	
		//将获得的内容变成字节数组，设置编码为utf-8
		byte[] contentBytes = content.getBytes("utf-8");
		//绘制二维码
		boolean[][] codeout = qrcode.calQrcode(contentBytes);
		for(int i = 0;i<codeout.length;i++)
		{
			for(int j = 0;j<codeout.length;j++)
			{
				if (codeout[j][i])
				{
					graphics2d.fillRect(j*3+2, i*3+2, 3, 3);
				}
			}
		}
		
		//释放画笔
		graphics2d.dispose();
		//刷新缓冲区
		image.flush();
		
		//给二维码图片起名字
		String fileName = UUID.randomUUID()+".jpg";
		FileOutputStream output = new FileOutputStream(new File("f:/",fileName));
		ImageIO.write(image, "jpg", output);
		//关闭流
		output.close();
		System.out.println("二维码图片生成成功!!!恭喜你!");
	}
}
