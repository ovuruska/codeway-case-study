


import 'package:codeway_case_project/common/Bloc.dart';
import 'package:codeway_case_project/components/Carousel/Model.dart';

class CarouselBloc extends Bloc<CarouselModel>{

  CarouselBloc(){
    subject.add(CarouselModel());
  }

  getNext(){
    subject.sink.add(subject.value.addNext());
  }

  setIndex(int index){
    subject.sink.add(subject.value.setIndex(index));
  }

}

final carouselBloc = CarouselBloc();