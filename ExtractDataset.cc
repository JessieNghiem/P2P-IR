/*
 * ExtractDataset.cpp
 *
 *  Created on: 23 Dec 2015
 *      Author: admin
 */
#include <fstream>
#include <iostream>
#include <random>
#include <functional>
#include <string>

#include "ExtractDataset.h"
#include "json/json.h"
#include "cqueue.h"
#include <queue>
#include "reviewjson.h"
#include <iostream>


int ExtractDataset::readDataset(std::string input, std::string output){
    Json::Value root;
    Json::Reader reader;
    //Json::StyledStreamWriter writer;
    Json::FastWriter writer;
    // Read json file
    std::ifstream readJsonFile(input, std::ifstream::binary);
    std::ofstream writeJsonFile(output, std::ofstream::binary);
    
    std::string cur_line;
    bool success;
	double min_longitude = 0;
	double max_longitude = 0;
	double min_latitude = 0;
	double max_latitude = 0;


    // Set random
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<double> dis_la(0, 28000);
    std::uniform_real_distribution<double> dis_lo(0, 32000);
    int node_id = 0;
    int cnt = 1;
    do {
        std::getline(readJsonFile, cur_line);
        success = reader.parse(cur_line, root, false);

        if(success) {


            root["longitude"] = dis_lo(gen);
            root["latitude"] = dis_la(gen);

            root["user_id"] = node_id;
            if((cnt % 5) != 0)
            {
                root["user_id"] = node_id;
                cnt++;
            }
            else
            {
                node_id++;
                cnt = 1;
            }
            std::string hash_string = std::to_string(root["user_id"].asInt()) + root["text_review"].asString() + root["business_id"].asString();
            std::hash<std::string> str_hash;
            root["hash_value"] = (unsigned int)str_hash(hash_string);

            //std::cout<<"content to write" << root.toStyledString();
            //writer.write(writeJsonFile, root);
            writeJsonFile<<writer.write(root);
			if(min_longitude == 0)
			{
				min_longitude = root["longitude"].asDouble();
				max_longitude = root["longitude"].asDouble();
				min_latitude = root["latitude"].asDouble();
				max_latitude = root["latitude"].asDouble();
			}
			else
			{
				if(min_longitude > root["longitude"].asDouble())
				{
					min_longitude = root["longitude"].asDouble();
				}
				else if(max_longitude < root["longitude"].asDouble())
				{
					max_longitude = root["longitude"].asDouble();
				}
				else if(min_latitude > root["latitude"].asDouble())
				{
					min_latitude = root["latitude"].asDouble();
				}
				else if(max_latitude < root["latitude"].asDouble())
				{
					max_latitude = root["latitude"].asDouble();
				}
			}
	}
    } while (success);
	//std::cout<<"min_longitude: "<<min_longitude<<" max_longitude: "<<max_longitude<<std::endl;
	//std::cout<<"min_latitude: "<<min_latitude<<" max_latitude"<<max_latitude<<std::endl;
    readJsonFile.close();
    writeJsonFile.close();
    return 0;
}

/*void ExtractDataset::setPCoord(Coord pLoc) {
    p = pLoc;
}

Coord ExtractDataset::getPCoord() {
    return p;
}*/

Coord ExtractDataset::p;

int ExtractDataset::extractKNN(int k, std::string input, std::string output, Coord pLoc) {
    ExtractDataset::p = pLoc;
    Json::Value root;
    Json::Reader reader;
    Json::FastWriter writer;

    std::ifstream readJsonFile(input, std::ifstream::binary);
    std::ofstream writeJsonFile(output, std::ofstream::binary);

    std::string cur_line;

    cQueue objectData; //object is an instance of reviewjson class
    objectData.setup(&distanceComp); //priority queue sorted by the distance to the moving object


    int cnt = 0;
    double maxDis = 0;

    bool success;

    std::getline(readJsonFile, cur_line);
    success = reader.parse(cur_line, root, false); //read the first line
    if(success) {
        Coord loc(root["longitude"].asDouble(), root["latitude"].asDouble());
        maxDis = loc.distance(pLoc);
        cnt++;
        objectData.insert(reviewjson(root).dup());
    }

    std::getline(readJsonFile, cur_line);
    success = reader.parse(cur_line, root, false); //read the next line
    while(success) {
        Coord loc(root["longitude"].asDouble(), root["latitude"].asDouble());
        double curDis = loc.distance(pLoc);
        if (cnt < k) { //if queue still has space
           objectData.insert(reviewjson(root).dup());
           cnt++;
           if (curDis > maxDis) maxDis = curDis;
        }
        else if (curDis < maxDis){ //if the queue is full, do replacement
            objectData.pop();
            objectData.insert(reviewjson(root).dup());
            //number of object does not change
        }

        std::getline(readJsonFile, cur_line);
        success = reader.parse(cur_line, root, false); //read the next line
    }

//loop through the queue to write to json file
    cQueue::Iterator it(objectData,0);//intialize iterator for Neighbor table
            //it.init(GNNs, 0);

    //EV<<"distance in the extract file"<<endl;
    while(!it.end())//iterate thru the queue
    {
        reviewjson* review = (reviewjson*)(cObject*)it();
        //for testing
        Json::Value root = review->getRoot();
        Coord loc(root["longitude"].asDouble(), root["latitude"].asDouble());

        double curDis = loc.distance(pLoc);
        //EV<<curDis<<endl;

        writeJsonFile<<writer.write(review->getRoot());
        it++;//move iterator to next table element
    }

    readJsonFile.close();
    writeJsonFile.close();
    return 0;

}


int ExtractDataset::distanceComp(cObject* one, cObject* another)
{
    reviewjson* object1 = static_cast<reviewjson*>(one);
    reviewjson* object2 = static_cast<reviewjson*>(another);

    Json::Value root1 = object1->getRoot();
    Json::Value root2 = object2->getRoot();

    Coord businessCoord1(root1["longitude"].asDouble(),
                    root1["latitude"].asDouble());

    Coord businessCoord2(root2["longitude"].asDouble(),
                        root2["latitude"].asDouble());

    double d1 = businessCoord1.distance(ExtractDataset::p);
    double d2 = businessCoord2.distance(ExtractDataset::p);

    if (d1 > d2)
        return 1;
    else if (d1 == d2)
        return 0;
    else
        return -1;
}

