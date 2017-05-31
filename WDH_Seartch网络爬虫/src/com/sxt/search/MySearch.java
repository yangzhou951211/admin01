package com.sxt.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * 利用java开发搜素引擎的爬虫
 * @author 王东海
 * @2016年11月20日
 */
public class MySearch
{
	/**
	 * 根据网址和页面的编码集 抓取网页的源代码
	 * @param url 网址
	 * @param encoding 网页的编码集
	 * @return 源代码
	 */
	public static String getHtmlResourceByURL(String url, String encoding)
	{
		// 在内存中声明一个存储网页源代码的容器
		StringBuffer buffer = new StringBuffer();
		// 需要的时候才实例化
		URL urlObj = null;
		URLConnection uc = null;
		InputStreamReader isr = null;
		BufferedReader br = null;

		try
		{
			// 建立网络连接(联网)
			urlObj = new URL(url);
			// 打开网络连接
			uc = urlObj.openConnection();
			// 建立网络的输入流
			isr = new InputStreamReader(uc.getInputStream(), encoding);
			// 网页源代码拿到本地。放在缓存器里面！ 建立缓冲写入文件流
			br = new BufferedReader(isr);

			// 创建文件流的临时变量 --因为文件一边读一边写存储，缓存到写入流中
			String temp = null;
			// 循环遍历文件的内容 一行一行的读取 ，直到为null就不循环
			while ((temp = br.readLine()) != null)
			{
				buffer.append(temp + "\n"); // 循环不断的追加 源代码
			}

		} catch (Exception e)
		{

			e.printStackTrace();
			System.out.println("连接网络超时 ...");
		} finally
		{
			// 关闭用到的文件流
			try
			{
				if (isr != null)
				{
					isr.close();
				}
			} catch (IOException e)
			{
				e.printStackTrace();
			}
		}
		// 强制类型转换
		return buffer.toString();
	}

	/**
	 * 根据一个图片的URL地址 批量下载网络图片到服务器的磁盘
	 * @param imgSrc 网络图片的绝对路径
	 * @param filePath 存储图片的服务器地址
	 * @return void 无返回值
	 */
	public static void dowmImages(String imgSrc, String filePath)
	{
		HttpURLConnection uc = null;
		FileOutputStream fos = null;
		try
		{
			// 创建文件的目录
			File files = new File(filePath);
			// 判断文件是否存在
			if (!files.exists())
			{
				// 如果不存在就创建一个文件夹
				files.mkdirs(); // 创建一个文件夹
			}
			// 获取图片文件的下载地址
			URL url = new URL(imgSrc);
			// 连接网络图片地址
			uc = (HttpURLConnection) url.openConnection();
			// 获取连接的输入流
			InputStream is = uc.getInputStream();
			// 截取文件名 http://mat1.gtimg.com/www/images/qq2012/gswj2015.jpg 截取成
			// gswj2015.jpg
			String fileName = imgSrc.substring(imgSrc.lastIndexOf("/"));
			File file = new File(filePath + fileName);
			// 创建输出流，写入文件
			fos = new FileOutputStream(file);
			int temp = 0;
			while ((temp = is.read()) != -1)
			{
				fos.write(temp); // 写入文件到本地
			}
			// 用完就关
			is.close();
			fos.close();

		} catch (Exception e)
		{
			e.printStackTrace(); // 打印堆栈信息
		}

	}

	// java的入口函数
	public static void main(String[] args)
	{

		System.out.println("");
		// 爬虫 指定的网址：
		String url = "http://www.qq.com/";
		// 网址里面的 源代码的编码集：
		String encoding = "gb2312";

		// 1 .根据网址(域名)和页面的编码集 抓取网页的源代码
		String htmlResource = getHtmlResourceByURL(url, encoding);
		// System.out.println("输出网页的源代码："+htmlResource);
		// 2 .解析网页的源代码 通过jsoup的parse方法解析
		Document document = Jsoup.parse(htmlResource);

		// 图片标签：<img src="" alt="" width="" height=""/>
		Elements elements = document.getElementsByTag("img"); // java版的js
		// 通过document获取图片标签
		// 返回值是 Elements
		// 循环遍历出 对象Elements中img标签 一组elements遍历成单个的一个element
		for (Element element : elements)
		{
			// 解析图片的路径 通过元素属性获得属性的值
			String imgSrc = element.attr("src");
			System.out.println("图片下载的地址" + imgSrc);

			// 下载图片到本地 只能下载绝对路径，相对路径会报错， 地址需要转义符\
			dowmImages(imgSrc, "F:\\网络爬虫项目\\tutu");

		}

		// 3 .通过条件语句进行筛选我们想要的信息

	}
}
