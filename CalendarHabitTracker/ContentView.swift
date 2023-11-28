import SwiftUI
import UIKit

class MyViewController: UIViewController, UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout
{

  var collectionView: UICollectionView!
  let colors: [UIColor] = [
    .red, .green, .blue, .yellow, .purple, .orange, .cyan, .magenta, .red, .green, .blue,
    .yellow,
    .red, .green, .blue, .yellow, .purple, .orange, .cyan, .magenta, .red, .green, .blue,
    .yellow,
    .red, .green, .blue, .yellow, .purple, .orange, .cyan, .magenta, .red, .green, .blue, .yellow,

  ]
  var cellSize: CGSize = CGSize(width: 100, height: 100)
  var currentScale: CGFloat = 1.0

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupPinchGesture()
  }

  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    self.view.addSubview(collectionView)
  }

  func setupPinchGesture() {
    let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
    collectionView.addGestureRecognizer(pinch)
  }

  @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
    if gesture.state == .changed {
      let scale = gesture.scale
        print(scale)

      // Update currentScale based on the pinch scale


      // Determine the number of items per row based on the current scale
      let itemsPerRow: CGFloat
      if scale <= 1 {
        itemsPerRow = 1
      } else if scale <= 1.5 {
        itemsPerRow = 7
      } else {
        itemsPerRow = 30
      }

      let totalSpacing =
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        * (itemsPerRow - 1)
        
      print(totalSpacing)
      let newWidth = (collectionView.bounds.width - totalSpacing) / itemsPerRow + 10
        print(newWidth)
      cellSize = CGSize(width: newWidth, height: newWidth)

        print(cellSize)
        
      collectionView.collectionViewLayout.invalidateLayout()

    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return colors.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      as! MyCollectionViewCell
    cell.backgroundColor = colors[indexPath.item % colors.count]
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return cellSize
  }
}

class MyCollectionViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews() {
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
}

// SwiftUI Preview
struct MyViewControllerPreview: PreviewProvider {
  static var previews: some View {
    ViewControllerPreview {
      MyViewController()
    }
  }
}

struct ViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
  let viewController: V

  init(_ builder: @escaping () -> V) {
    viewController = builder()
  }

  func makeUIViewController(context: Context) -> V {
    viewController
  }

  func updateUIViewController(_ uiViewController: V, context: Context) {
  }
}
