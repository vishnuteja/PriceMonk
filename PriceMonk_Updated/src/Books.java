public class Books {

	private String author;
	private String edition;
	private String tag;
	private String publisher;
	private String language;
	private String ISBN;
	private String ISBN_N;
	private String pages;
	private float File_Size;
	private String format;
	
	Books()
	{
		author = null;
		edition = null;
		tag = null;
		publisher = null;
		language = null;
		ISBN = null;
		pages = null;
		ISBN_N = null;
		File_Size = 0;
		format = null;
	}

	/**
	 * @return the pages
	 */
	public String getPages() {
		return pages;
	}

	/**
	 * @param pages the pages to set
	 */
	public void setPages(String pages) {
		this.pages = pages;
	}

	/**
	 * @return the author
	 */
	public String getAuthor() {
		return author;
	}

	/**
	 * @param author the author to set
	 */
	public void setAuthor(String author) {
		this.author = author;
	}

	/**
	 * @return the edition
	 */
	public String getEdition() {
		return edition;
	}

	/**
	 * @param edition the edition to set
	 */
	public void setEdition(String edition) {
		this.edition = edition;
	}

	/**
	 * @return the tag
	 */
	public String getTag() {
		return tag;
	}

	/**
	 * @param tag the tag to set
	 */
	public void setTag(String tag) {
		this.tag = tag;
	}

	/**
	 * @return the publisher
	 */
	public String getPublisher() {
		return publisher;
	}

	/**
	 * @param publisher the publisher to set
	 */
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	/**
	 * @return the language
	 */
	public String getLanguage() {
		return language;
	}

	/**
	 * @param language the language to set
	 */
	public void setLanguage(String language) {
		this.language = language;
	}

	/**
	 * @return the iSBN
	 */
	public String getISBN() {
		return ISBN;
	}

	/**
	 * @param iSBN the iSBN to set
	 */
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}

	/**
	 * @return the iSBN_N
	 */
	public String getISBN_N() {
		return ISBN_N;
	}

	/**
	 * @param iSBN_N the iSBN_N to set
	 */
	public void setISBN_N(String iSBN_N) {
		ISBN_N = iSBN_N;
	}

	/**
	 * @return the file_Size
	 */
	public float getFile_Size() {
		return File_Size;
	}

	/**
	 * @param file_Size the file_Size to set
	 */
	public void setFile_Size(float file_Size) {
		File_Size = file_Size;
	}

	/**
	 * @return the format
	 */
	public String getFormat() {
		return format;
	}

	/**
	 * @param format the format to set
	 */
	public void setFormat(String format) {
		this.format = format;
	}
}
