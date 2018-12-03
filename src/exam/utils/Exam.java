package exam.utils;

import java.io.Serializable;

import java.util.Date;

public class Exam implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String ename;
	private Date etime;
	private boolean eautostart;
	private boolean eactive;
	private boolean efinish;
	private boolean earchived;
	private boolean ecleared;
	private String epaper;
	private String etype;

	public Exam() {
	}

	public Exam(String ename, Date etime) {
		this.ename = ename;
		this.etime = etime;
	}

	public Exam(String ename, Date etime, boolean eautostart, boolean eactive, boolean efinish, boolean earchived,
			boolean ecleared, String epaper, String etype) {
		this.ename = ename;
		this.etime = etime;
		this.eautostart = eautostart;
		this.eactive = eactive;
		this.efinish = efinish;
		this.earchived = earchived;
		this.ecleared = ecleared;
		this.epaper = epaper;
		this.etype = etype;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	

	public String getEname() {
		return this.ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getEpaper() {
		return this.epaper;
	}

	public void setEpaper(String epaper) {
		this.epaper = epaper;
	}

	public String getEtype() {
		return this.etype;
	}

	public void setEtype(String etype) {
		this.etype = etype;
	}

	public Date getEtime() {
		return this.etime;
	}

	public void setEtime(Date etime) {
		this.etime = etime;
	}

	public boolean isEautostart() {
		return this.eautostart;
	}

	public void setEautostart(boolean eautostart) {
		this.eautostart = eautostart;
	}

	public boolean isEactive() {
		return this.eactive;
	}

	public void setEactive(boolean eactive) {
		this.eactive = eactive;
	}

	public boolean isEfinish() {
		return this.efinish;
	}

	public void setEfinish(boolean efinish) {
		this.efinish = efinish;
	}

	public boolean isEarchived() {
		return this.earchived;
	}

	public void setEarchived(boolean earchived) {
		this.earchived = earchived;
	}

	public boolean isEcleared() {
		return this.ecleared;
	}

	public void setEcleared(boolean ecleared) {
		this.ecleared = ecleared;
	}
}