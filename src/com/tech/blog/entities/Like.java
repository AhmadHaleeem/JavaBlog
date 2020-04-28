package com.tech.blog.entities;

public class Like {
	
	private int lid;
	private int pid;
	private int uid;
	public Like(int lid, int pid, int uid) {
		super();
		this.lid = lid;
		this.pid = pid;
		this.uid = uid;
	}
	public Like(int pid, int uid) {
		super();
		this.pid = pid;
		this.uid = uid;
	}
	
	
}
