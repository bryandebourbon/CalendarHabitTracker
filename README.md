MagnifyCalendarView
===================
Adapt UIKit's {Collection View} with a {Pinch Guesture} for {SwiftUI}.

Features
=========
A. CollectionView? => UICollectionView, UIViewController
B. PinchGuesture? => UIPinchGestureRecognizer
C. SwiftUI? => UIViewControllerRepresentable

Dependancy Map:
========================

A. UICollectionView(a1,a2,a3,a4)
------------------------------
a1. frame: view.bounds
a2. collectionViewLayout:
    UICollectionViewFlowLayout() {
        collectionView(sizeForItemAt)
            {* return appropriate size of cell *}
    } 
a3. dataSource:
    UICollectionViewDataSource {
        collectionView(numberOfItemsInSection) -> Int 
            {* return number of items in collection *}
        collectionView(cellForItemAt) -> UICollectionViewCell
            {* return how each view should look *}
    }
a4. delegate:
    UICollectionViewDelegateFlowLayout {
        collectionView(numberOfItemsInSection) -> Int 
            {* return number of items in collection *}
        collectionView(cellForItemAt) -> UICollectionViewCell
            {* return how each view should look *}
    }

B. UIPinchGestureRecognizer(b1,b2) 
------------------------------
b1. target: 
        {* some viewcontroller *}
b2. action: 
        {* link guesture to SCALE_FACTOR *} 


C. UIViewControllerRepresentable{c1,c2} 
-------------------------------------------
c1. makeUIViewController 
        {*creates the view controller object and configures its initial state.*}
    
c2. updateUIViewController 
        {*updates the state of the specified view controller with new information from SwiftUI.*}
    
