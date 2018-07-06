//
//  ViewController.swift
//  Questions
//
//  Created by Arslan Ali on 6/7/18.
//  Copyright © 2018 Arslan Ali. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    
    var answersArray = [["1:) 18","2:) 23","3:) 40","4:) 20","5:) 22","6:) 25"],["1:) 18","2:) 23","3:) 40"],["1:) 18","2:) 23","3:) 40","4:) 20","5:) 22","6:) 25","7:) 50"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: "id")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! BaseCell
        cell.answersArray = self.answersArray[indexPath.row]
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}


class BaseCell:UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    var answersArray:[String]?{
        didSet{
            DispatchQueue.main.async {
                self.answersCollectionView.reloadData()
            }
        }
    }
    let questionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Q:1) Whats your age?"
        return label
    }()
    
    lazy var answersCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout:layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.register(AnswersCell.self, forCellWithReuseIdentifier: "id")
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(questionLabel)
        addSubview(answersCollectionView)
        questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        
        answersCollectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        answersCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        answersCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        answersCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 40, height: 40)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answersArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! AnswersCell
        cell.answersLabel.text = self.answersArray?[indexPath.row]
        return cell
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AnswersCell:UICollectionViewCell{
    
    let answersLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(answersLabel)
        answersLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        answersLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        answersLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
