#!/usr/bin/env bash

BUILD_APP_BUNDLE=false

function checkResult {
  RESULT=$?
  if [ $RESULT != 0 ]; then
    log "Previous command failed!"
    exit $RESULT
  fi
}

function log {
    m_time=$(date "+%F %T")
    echo "$m_time $1"
}

while getopts "b" opt; do
  case ${opt} in
  b)
    BUILD_APP_BUNDLE=true
    ;;
  \?)
    log "Invalid option: $OPTARG" 1>&2
    ;;
  :)
    log "Invalid option: $OPTARG requires an argument" 1>&2
    ;;
  esac
done
shift $((OPTIND - 1))

log "Running clean step..."
flutter clean
checkResult

log "Running pub get..."
flutter pub get
checkResult

log "Running build runner step..."
flutter pub run build_runner build --delete-conflicting-outputs
checkResult

log "Running analyze step..."
flutter analyze
checkResult

#log "Running tests step..."
#flutter test test/*
#checkResult

if [ "$BUILD_APP_BUNDLE" = true ]; then
  log "Running app bundle build..."
  flutter build appbundle
  checkResult
fi

log "Project build complete."