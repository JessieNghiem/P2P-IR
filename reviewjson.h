/*
 * reviewjson.h
 *
 *  Created on: Mar 23, 2016
 *      Author: jessie
 */

#ifndef REVIEWJSON_H_
#define REVIEWJSON_H_

#include "json/json.h"
#include "cobject.h"
#include "Coord.h"

class reviewjson : public cObject {
public:
    reviewjson();
    reviewjson(const Json::Value r);
    reviewjson(const reviewjson *other);
    reviewjson(const reviewjson& other);
    reviewjson& operator=(const reviewjson& other);

    virtual ~reviewjson();

    //static int distanceComp(cObject* one, cObject* another);

    Json::Value getRoot() const;
    void setRoot(Json::Value r);
    /*Coord getPCoord() const;
    void setPCoord(Coord p);*/
    virtual reviewjson* dup() const;

private:
    Json::Value root;
    //Coord pCoord;
};

#endif /* REVIEWJSON_H_ */
