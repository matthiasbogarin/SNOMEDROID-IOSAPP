//
//  hierarchyClass.swift
//  SNOMEDROID
//
//  Created by Leon Wu on 3/31/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import Foundation

struct hierarchyClass {
    var bodyStructure: [String]
    var finding : [String]
    var enviroLocation : [String]
    var event : [String]
    var organism : [String]
    var observableEntity:[String]
    var product : [String]
    var physicalForce : [String]
    var physicalObject : [String]
    var procedure : [String]
    var qualifierValue : [String]
    var recordArtifact : [String]
    var situation : [String]
    var metadata : [String]
    var socialConcept : [String]
    var specialConcept : [String]
    var specimen : [String]
    var stagingScale : [String]
    var substance : [String]
    
    init(){
        self.bodyStructure = ["(body structure)", "(cell)","(cell structure)", "(morphological abnormality)"]
        self.finding = ["(finding)","(disorder)"]
        self.enviroLocation  = ["(environment)","(geographic location)"]
     self.event = ["(event)"]
    self.observableEntity  = ["(observable entity)"]
     self.organism  = ["(organism)"]
     self.product  = ["(clinical drug)","(medicinal product)","(medicinal product form)","(physical object)","(product)"]
     self.physicalForce = ["(physical force)"]
        self.physicalObject = ["(physical object)","(product)"]
        self.procedure = ["(procedure)","(regime/therapy)"]
     self.qualifierValue  = ["(qualifier value)","(administration method)","(basic dose form)","(disposition)","(dose form)","(intended site)","(number)","(product name)","(release characteristic)","(role)","(state of matter)","(transformation)","(supplier)","(unit of presentation)"]
   self.recordArtifact  = ["(record artifact)"]
     self.situation  = ["(situation)"]
     self.metadata  = ["(attribute)","(core metadata concept)","(foundation metadata concept)","(link assertion)","(linkage concept)","(namespace concept)","(OWL metadata concept)"]
        self.socialConcept = ["(social concept)","(ethnic group)","(life style)","(occupation)","(person)","(racial group)","(religion/philosophy)"]
    self.specialConcept  = ["(inactive concept)","(navigational concept)"]
    self.specimen  = ["(specimen)"]
     self.stagingScale = ["(staging scale","(assessment scale)","(tumor staging)"]
     self.substance  = ["(substance)"]
    }
}



