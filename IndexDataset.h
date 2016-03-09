/*
 * IndexDataset.h
 *
 *  Created on: Mar 8, 2016
 *      Author: jessie
 */

#ifndef INDEXDATASET_H_
#define INDEXDATASET_H_


#include "Index.h"
#include <string>
#include "json/json.h"
#include "Document.h"

using namespace std;

class IndexDataset {
public:
    vector<string> attr_key;
    map<string, string> stopList;

public:
    void parseText(string& contents, unsigned int key, Index* index);
    void appendAttributes(string& str, Json::Value& attributes);
    void appendCategories(string& str, Json::Value& categories);
    void createTermIndex(string path, Index* index, map<unsigned int, Document>& docMap);
    void readStopList(string stopListPath);
    void writeFile(map<string, Lexicon>& lexicon, map<unsigned int, Document>& docMap,
            string lexiconFilePath, string invlistsFilePath, string docMapFilePath);
};


#endif /* INDEXDATASET_H_ */
