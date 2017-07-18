import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Date;
import java.util.Iterator;
import java.util.Vector;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

@SuppressWarnings("rawtypes")
public class ExceltoJava {

		private static Product P = new Product();
		private static Books B = new Books();
		
	    public static void main(String[] args) throws IOException
        {
                String fileName = "Project.xls";
                ReadCSV(fileName);
                //productDataToDB(dataHolder);
        }

		@SuppressWarnings("unchecked")
		public static void ReadCSV(String fileName)
        {
                Vector productVector = new Vector();
                Vector bookVector = new Vector();
                
                try
                {
                        FileInputStream myInput = new FileInputStream(fileName);
                        POIFSFileSystem myFileSystem = new POIFSFileSystem(myInput);
                        HSSFWorkbook myWorkBook = new HSSFWorkbook(myFileSystem);
                        HSSFSheet mySheet1 = myWorkBook.getSheetAt(0);
                        Iterator rowIter1 = mySheet1.rowIterator();
                        HSSFSheet mySheet2 = myWorkBook.getSheetAt(1);
                        Iterator rowIter2 = mySheet2.rowIterator();
                        
                        // Retrieving Product details
                        while (rowIter1.hasNext())
                        {
                                HSSFRow myRow = (HSSFRow) rowIter1.next();
                                Iterator cellIter = myRow.cellIterator();
                                Vector cellStoreVector = new Vector();
                                
                                while (cellIter.hasNext())
                                {
                                        HSSFCell myCell = (HSSFCell) cellIter.next();
                                        cellStoreVector.addElement(myCell);
                                }
                                
                                productVector.addElement(cellStoreVector);
                        }
                        
                        // Retrieving Book details
                        while (rowIter2.hasNext())
                        {
                                HSSFRow myRow = (HSSFRow) rowIter2.next();
                                Iterator cellIter = myRow.cellIterator();
                                Vector cellStoreVector = new Vector();
                                
                                while (cellIter.hasNext())
                                {
                                        HSSFCell myCell = (HSSFCell) cellIter.next();
                                        cellStoreVector.addElement(myCell);
                                }
                                
                                bookVector.addElement(cellStoreVector);
                        }
                        productDataToDB(productVector);
                        bookDataToDB(bookVector);
                }
                
                catch (Exception e)
                {
                        e.printStackTrace();
                }
                //return productVector;
               
        }

        private static void bookDataToDB(Vector dataHolder) throws IOException
        {
        	
        		Connection con = null;
        		String url = "jdbc:mysql://localhost:3306/";
        		String dbName = "pricemonk";
        		String driver = "com.mysql.jdbc.Driver";

        	    for (int i = 0; i < dataHolder.size(); i++)
                {
        				int j = 0;
                        Vector cellStoreVector = (Vector) dataHolder.elementAt(i);
                  	  	
                        HSSFCell productID = (HSSFCell) cellStoreVector.elementAt(j);
                        String PID = productID.toString();
                        //P.setProductID(PID);
                        j++;
                        HSSFCell name = (HSSFCell) cellStoreVector.elementAt(j);
                        String author = name.toString();
                        B.setAuthor(author);
                        j++;
                        HSSFCell e = (HSSFCell) cellStoreVector.elementAt(j);
                        String edition = e.toString();
                        B.setEdition(edition);
                        j++;
                        HSSFCell t = (HSSFCell) cellStoreVector.elementAt(j);
                        String tag = t.toString();
                        B.setTag(tag);
                        j++;
                        HSSFCell pub = (HSSFCell) cellStoreVector.elementAt(j);
                        String publisher = pub.toString();
                        B.setPublisher(publisher);
                        j++;
                        HSSFCell lang = (HSSFCell) cellStoreVector.elementAt(j);
                        String language = lang.toString();
                        B.setLanguage(language);
                        j++;
                        HSSFCell p = (HSSFCell) cellStoreVector.elementAt(j);
                        String pages = p.toString();
                        B.setPages(pages);
                        j++;
                        HSSFCell isbn = (HSSFCell) cellStoreVector.elementAt(j);
                        String ISBN = isbn.toString();
                        B.setISBN(ISBN);
                        j++;
                        HSSFCell isbn_n = (HSSFCell) cellStoreVector.elementAt(j);
                        String ISBN_N = isbn_n.toString();
                        B.setISBN_N(ISBN_N);
                        j++;
                        HSSFCell size = (HSSFCell) cellStoreVector.elementAt(j);
                        float file_size = Float.parseFloat(size.toString());
                        B.setFile_Size(file_size);
                        j++;
                        HSSFCell format = (HSSFCell) cellStoreVector.elementAt(j);
                        String file_format = format.toString();
                        B.setFormat(file_format);
                        
                        try
            			{
            				Class.forName(driver).newInstance();
            				con = DriverManager.getConnection(url+dbName,"root","aditya");
            				System.out.println("Connected to the database");
            				Statement smt=  con.createStatement();
            				String query = "insert into Books values ('"+PID+"','"+B.getAuthor()+"',"+B.getEdition()+",'"+
            								B.getTag()+"','"+B.getPublisher()+"','"+B.getLanguage()+"',"+B.getPages()+",'"+B.getISBN()+"','"+
            								B.getISBN_N()+"',"+B.getFile_Size()+",'"+B.getFormat()+"')";
            				smt.executeUpdate(query);
            				smt.close();
            				con.close();
            			}
            			catch (Exception ex)
            			{
            				System.out.println(ex);
            			}
            			
                      
                   }
                
              
        }
        private static void productDataToDB(Vector dataHolder) throws IOException
        {
        	
        		Connection con = null;
        		String url = "jdbc:mysql://localhost:3306/";
        		String dbName = "pricemonk";
        		String driver = "com.mysql.jdbc.Driver";

        	    for (int i = 0; i < dataHolder.size(); i++)
                {
        				int j = 0;
                        Vector cellStoreVector = (Vector) dataHolder.elementAt(i);
                  	  	
                        HSSFCell productID = (HSSFCell) cellStoreVector.elementAt(j);
                        String PID = productID.toString();
                        P.setProductID(PID);
                        j++;
                        HSSFCell name = (HSSFCell) cellStoreVector.elementAt(j);
                        String title = name.toString();
                        P.setTitle(title);
                        j++;
                        HSSFCell date = (HSSFCell) cellStoreVector.elementAt(j);
                        java.util.Date d = (Date)date.getDateCellValue();
                        P.setReleaseDate(d);
                        j++;
                        HSSFCell cost = (HSSFCell) cellStoreVector.elementAt(j);
                        String C = cost.toString();
                        float price = Float.parseFloat(C);
                        P.setPrice(price);
                        j++;
                        HSSFCell wt = (HSSFCell) cellStoreVector.elementAt(j);
                        String W = wt.toString();
                        float weight = Float.parseFloat(W);
                        P.setShippingWeight(weight);
                        j++;
                        HSSFCell r = (HSSFCell) cellStoreVector.elementAt(j);
                        float rank = Float.parseFloat(r.toString());
                        P.setRank(rank);
                        
                        try
            			{
            				Class.forName(driver).newInstance();
            				con = DriverManager.getConnection(url+dbName,"root","aditya");
            				System.out.println("Connected to the database");
            				java.sql.Date sqldate = new java.sql.Date(P.getReleaseDate().getTime());
            				Statement smt=  con.createStatement();
            				String query = "insert into Products values ('"+P.getProductID()+"','"+P.getTitle()+"','"+sqldate+"',"+
            								P.getPrice()+","+P.getShippingWeight()+","+P.getRank()+")";
            				smt.executeUpdate(query);
            				smt.close();
            				con.close();
            			}
            			catch (Exception e)
            			{
            				System.out.println(e);
            			}
            			
                      
                   }
                
              
        }
}