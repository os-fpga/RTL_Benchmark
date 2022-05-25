class data_recorder
{
	private:
		string block_name;
		string html_title;
		vector<string> columns;
		string path_to_save;
		FILE * pFile;
	public:
	data_recorder(string nameblock,vector<string> data_col,string path,string title)
	{
		block_name   = nameblock;
		path_to_save = path;
		columns      = data_col;
		html_title   = title;
	}

	void initialize()
	{
		string aux;
		pFile = fopen (path_to_save.c_str(),"w");
		fprintf (pFile,"<!DOCTYPE html>\n");
		fprintf (pFile,"<html>\n");
		fprintf (pFile,"<head>\n");
		fprintf (pFile,"<title>\n");
		fprintf (pFile,html_title.c_str());
		fprintf (pFile,"</title>\n");
		fprintf (pFile,"<style>\n");
		fprintf (pFile,"table, th, td\n");
		fprintf (pFile,"{\n");
		fprintf (pFile,"		border: 1px solid black;\n");
		fprintf (pFile,"		border-collapse: collapse;}\n");
		fprintf (pFile,"th, td {\n");
		fprintf (pFile,"		padding: 5px;\n");
		fprintf (pFile,"}\n");
		fprintf (pFile,"</style>\n");
		fprintf (pFile,"</head>\n");
		fprintf (pFile,"<body>\n");
		fprintf (pFile,"<table align = \"center\" style=\"width:65%\">\n");
		fprintf (pFile,"<tr>\n");
		for(unsigned int a = 0; a < columns.size();a++)
		{
			aux = columns[a];
			fprintf (pFile,"<th align = \"center\">%s\n</th>\n",aux.c_str());
		}
		fprintf (pFile,"</tr>\n");
	}

	void storedata(vector<string> data_line_store)
	{
		string aux;
		fprintf (pFile,"<tr>\n");
		for(unsigned int a = 0; a < columns.size();a++)
		{
			aux = data_line_store[a];
			fprintf (pFile,"<td align = \"center\">\n");
			fprintf (pFile,"%s\n",aux.c_str());
			fprintf (pFile,"</td>\n");
		}
		fprintf (pFile,"</tr>\n");
	}

	void endsimulation()
	{
		fprintf (pFile,"</table>\n");
		fprintf (pFile,"</body>\n");
		fprintf (pFile,"</html>\n");
		fclose (pFile);
	}

};
