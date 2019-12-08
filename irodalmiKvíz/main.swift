//
//  main.swift
//  irodalmiKvíz
//
//  Created by Gergely Kovacs on 2019. 12. 06..
//  Copyright © 2019. Gergely Kovacs. All rights reserved.
//

import Foundation

class QuestionNode {
    let value: String
    let leftNode: QuestionNode?
    let middleNode: QuestionNode?
    let rightNode: QuestionNode?
    let answers: [Int:String]?
    
    init(value: String, leftNode: QuestionNode?,middleNode: QuestionNode?, rightNode: QuestionNode?, answers: [Int:String]?) {
        self.value = value
        self.leftNode = leftNode
        self.middleNode = middleNode
        self.rightNode = rightNode
        self.answers = answers
    }
}

//Leafs
let ady = QuestionNode(value: "Ady", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let petőfi = QuestionNode(value: "Petőfi", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let kosztolányi = QuestionNode(value: "Kosztolányi", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let berzsenyi = QuestionNode(value: "Berzsenyi", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let vörösmarty = QuestionNode(value: "Vörösmarty", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let arany = QuestionNode(value: "Arany János", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
let józsefAttila = QuestionNode(value: "József Attila", leftNode: nil, middleNode: nil, rightNode: nil, answers: nil)
//Nodes
let nehéz = QuestionNode(value: "Nehéz neki?", leftNode: kosztolányi, middleNode: józsefAttila, rightNode: arany, answers: [1 : "igen, de egy ugrálóvár feldobná",  2 : "igen", 3 : "nem neki, de nehéz"])
let szavakat = QuestionNode(value: "A szavakat érted?", leftNode: berzsenyi, middleNode: vörösmarty, rightNode: nehéz, answers: [1 : "nem", 2 : "többnyire", 3 : "teljesen"])
let örül = QuestionNode(value: "Úgy örül, mint egy hatéves az ugrálóvárnak?", leftNode: kosztolányi, middleNode: szavakat, rightNode: nil, answers: [1 : "igen", 2 : "nem"])
let húszFőnél = QuestionNode(value: "Húsz főnél nagyobb demonstráción működik?", leftNode: petőfi, middleNode: ady, rightNode: nil , answers: [1 : "igen", 2 : "nem"])
let bánthatna = QuestionNode(value: "Ha bánthatna megtenné?", leftNode: örül, middleNode: húszFőnél, rightNode: ady, answers: [1 : "nem", 2 : "esetleg", 3 : "biztosan"])
// Root
let rootNode = QuestionNode(value: "Egyértelmű önfényezés?", leftNode: ady, middleNode: bánthatna, rightNode: nil, answers: [1 : "igen", 2 : "nem" ])

struct PoeticQuiz {
    var rootNode: QuestionNode?
   
    func startQuiz(question: QuestionNode?)  {
        var currentQuestion = question
        let answersStrings = currentQuestion?.answers?.sorted(by: { (arg0, arg1) -> Bool in
            
            let (key, value) = arg0
            let (key1, value1) = arg1
            return (key, value) < (key1, value1)
        })
        if let answers = answersStrings {
            print("\(currentQuestion?.value ?? "")\n")
            answers.forEach {
                print($0.key, $0.value)
            }
        }
        
         let answer = Int(readLine() ?? "")
        while currentQuestion?.answers != nil {
            switch answer {
        case 1:
            currentQuestion = currentQuestion?.leftNode
            handleResults(question: currentQuestion)
        case 2:
            currentQuestion = currentQuestion?.middleNode
            handleResults(question: currentQuestion)
        case 3:
            currentQuestion = currentQuestion?.rightNode
            handleResults(question: currentQuestion)

        default:
            break
        }
           
    }
}
    init(rootNode: QuestionNode?) {
        self.rootNode = rootNode
    }
    
    func handleResults(question: QuestionNode?) {
        let currentQuestion = question
        guard currentQuestion != nil else {return}
        if currentQuestion?.answers == nil {
        print(currentQuestion?.value ?? "")
        print("Újrapróbálod? i/n")
        let continueAnswer = readLine()
        switch continueAnswer {
            case "i":
                startQuiz(question: rootNode)
            case "n":
                exit(0)
             default:
                print("igen: i, nem: n")
                }
            } else {
                startQuiz(question: currentQuestion)
        }
    }
}

let myQuiz = PoeticQuiz(rootNode: rootNode)
myQuiz.startQuiz(question: rootNode)
