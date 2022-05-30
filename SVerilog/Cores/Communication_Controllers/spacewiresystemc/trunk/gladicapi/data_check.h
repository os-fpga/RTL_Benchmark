class data_check
{
	private:
		string cmp1,cmp2;
	public:
	data_check()
	{

	}

	void compare_test(vector<string> *data)
	{
		cmp1 = data->at(1);
		cmp2 = data->at(2);
		if(cmp1.compare(cmp2) == 0)
		{
			data->at(3) = "EQUAL";
		}else
		{
			data->at(3) = "NOT EQUAL";
		}
	}

};
