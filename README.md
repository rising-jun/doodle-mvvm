# doodle-mvvm
----
## RxSwift + MVVM
- Input(Action), Output(State), Bind를 추상화한 후 이들을 채택한 ViewModelType추상타입을 ViewModel이 채택하도록 하였습니다.
- DoodleViewController는 의존성(DoodleDependency)을 주입받고 ViewModel은 추상타입으로 선언되어있습니다.
- RxCocoa를 활용하여 CollectionView의 데이터를 간편하게 주입하였습니다.
- Input, Output은 RxRelay의 PublishRelay를 사용하여 View와 ViewModel이 데이터를 주고 바인딩하도록 구현하였습니다.

## RxTest
- RxTest를 사용하여 테스트하였습니다.

### 구조
<img width="1413" alt="스크린샷 2022-08-04 오후 5 32 30" src="https://user-images.githubusercontent.com/62687919/182801905-9d634b22-2cdb-41a8-b87b-bda37543abac.png">
