public class CalBox
{
	private string bingHome = "https://www.bing.com/";
	private string query = "search?q=Featured+on+Bing&form=hpcapt";
	private string beforeDate = "&filters=HpDate:%22";
	private string afterDate = "_0700%22";
	
	[Required]
	public int UnixDate { get; set; }

	public string BigPicId { get; set; }

	[Required]
	public string PicDescrip { get; set; }
} // https://dotnet.microsoft.com/en-us/apps/aspnet/mvc


/* always a 7x5 grid to place calboxes */
/* grid col position is derived by feeding unix timestamp to hopefully a C# date class and getting a string,
like js, and from the part of string about day derive grid col index from enum { Sun Mon Tue ...} */
/* row position not as straightforward, it's dependent on first of the month. row position could be linked list-ish */
// https://www.bing.com/search?q=Featured+on+Bing&form=hpcapt&filters=HpDate:%22_0700%22
