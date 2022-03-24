/*
 * Copyright (c) 2016 by Alex I. Kuznetsov.
 *
 * Part of the LXP32 CPU IP core.
 *
 * This module defines the LinkableObject class which represents
 * compiled LXP32 binary code.
 */

#ifndef LINKABLEOBJECT_H_INCLUDED
#define LINKABLEOBJECT_H_INCLUDED

#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <cstdint>

class LinkableObject {
public:
	typedef unsigned char Byte;
	typedef std::uint32_t Word;
	
	enum SymbolType {Unknown,Local,External};
	struct Reference {
		std::string source;
		int line;
		Word rva;
	};
	struct SymbolData {
		SymbolType type=Unknown;
		Word rva;
		std::vector<Reference> refs;
	};
	typedef std::map<std::string,SymbolData> SymbolTable;
	
private:
	std::string _name;
	std::vector<Byte> _code;
	SymbolTable _symbols;
	Word _virtualAddress=0;
	
public:
	std::string name() const;
	void setName(const std::string &str);
	
	Word virtualAddress() const;
	void setVirtualAddress(Word addr);
	
	Byte *code();
	const Byte *code() const;
	std::size_t codeSize() const;
	
	Word addWord(Word w);
	Word addByte(Byte b);
	Word addBytes(const Byte *p,std::size_t n);
	Word addZeros(std::size_t n);
	
	Word addPadding(std::size_t size=sizeof(LinkableObject::Word));
	
	Word getWord(Word rva) const;
	void replaceWord(Word rva,Word value);
	
	void addLocalSymbol(const std::string &name,Word rva);
	void addExternalSymbol(const std::string &name);
	void addReference(const std::string &symbolName,const std::string &source,int line,Word rva);
	
	SymbolData &symbol(const std::string &name);
	const SymbolData &symbol(const std::string &name) const;
	const SymbolTable &symbols() const;
	
	void serialize(const std::string &filename) const;
	void deserialize(const std::string &filename);

private:
	void deserializeCode(std::istream &in);
	void deserializeSymbol(std::istream &in);	
	static std::vector<std::string> tokenize(const std::string &str);
};

#endif
