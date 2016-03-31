/*
 * ExtractDataset.h
 *
 *  Created on: 23 Dec 2015
 *      Author: admin
 */


#ifndef EXTRACTDATASET_H_
#define EXTRACTDATASET_H_

#include <string>
#include <map>

#include "Business.h"
#include "Coord.h"

class ExtractDataset {
public:
    /*
     * Map for business list, include their review.
     * The key is: businessId?userId
     * which is combined with business id and user id connected with symbol '?'
     * */
    std::vector<Business> businessList;

    int readDataset(std::string input, std::string output);
    int extractKNN(int k, std::string input, std::string output, Coord p);
    //static void setPCoord(Coord pLoc);
    static int distanceComp(cObject* one, cObject* another);
    //static Coord getPCoord();

    static Coord p; //position of the moving peer
};



#endif /* EXTRACTDATASET_H_ */
