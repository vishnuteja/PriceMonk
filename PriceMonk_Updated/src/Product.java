import java.util.Date;


public class Product {
	
	private String productID;
	private String title;
	private Date releaseDate;
	private float price;
	private float shippingWeight;
	private float rank;
	
	Product()
	{
		productID = null;
		title = null;
		releaseDate = null;
		price = 0;
		shippingWeight = 0;
		rank = 0;
	}

	/**
	 * @return the productID
	 */
	public String getProductID() {
		return productID;
	}

	/**
	 * @param productID the productID to set
	 */
	public void setProductID(String productID) {
		this.productID = productID;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the releaseDate
	 */
	public Date getReleaseDate() {
		return releaseDate;
	}

	/**
	 * @param releaseDate the releaseDate to set
	 */
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	/**
	 * @return the price
	 */
	public float getPrice() {
		return price;
	}

	/**
	 * @param price the price to set
	 */
	public void setPrice(float price) {
		this.price = price;
	}

	/**
	 * @return the shippingWeight
	 */
	public float getShippingWeight() {
		return shippingWeight;
	}

	/**
	 * @param shippingWeight the shippingWeight to set
	 */
	public void setShippingWeight(float shippingWeight) {
		this.shippingWeight = shippingWeight;
	}

	/**
	 * @return the rank
	 */
	public float getRank() {
		return rank;
	}

	/**
	 * @param rank the rank to set
	 */
	public void setRank(float rank) {
		this.rank = rank;
	}
}
