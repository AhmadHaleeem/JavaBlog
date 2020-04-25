package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	public static boolean deleteFile(String path) {
		boolean f = false;

		try {
			File file = new File(path);
			f = file.delete();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public static boolean saveFile(InputStream is, String path) {
		boolean f = false;

		try {
			byte b[] = new byte[is.available()];

			is.read(b);

			FileOutputStream fileOutputStream = new FileOutputStream(path);
			fileOutputStream.write(b);

			fileOutputStream.flush();
			fileOutputStream.close();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
}
